# frozen_string_literal: true

class Feedlist < ActiveRecord::Base
  paginates_per 5

  belongs_to :feed, touch: true
  belongs_to :user

  def self.usuario(user, rssurl)
    @feed = Feed.where(user_id: user.to_i, rssurl: rssurl.to_s).last
  end

  def self.search(search)
    if search
      where('name ILIKE ? OR summary ILIKE ?',
            "%#{search}%", "%#{search}%").order('created_at DESC')
    else
      all
    end
  end

  def self.update_from_feed(feed_url)
    set_media_feed

    feed = Feedjira::Feed.fetch_and_parse(feed_url)

    if feeds.is_a?(Integer)

      redirect_to root_path

    else

      feed.entries.each do |entry|
        if entry.published.nil?

          @datafeedlist == Time.now

        else

          @datafeedlist = entry.published

        end

        next unless exists? guid: entry.id

        create!(
          rssurl: feed.rssurl,
          name: entry.title,
          summary: entry.summary,
          url: entry.url,
          published_at: @datafeedlist,
          guid: entry.id,
          image: entry.media_thumbnail_url,
          feed_id: @feed.id
        )
      end
    end
  end

  private

  def set_media_feed
    Feedjira::Feed.add_common_feed_entry_element(
      'media:thumbnail',
      value: :url,
      as: :media_thumbnail_url
    )

    Feedjira::Feed.add_common_feed_entry_element(
      'enclosure',
      value: :url,
      as: :media_thumbnail_url
    )
  end
end
