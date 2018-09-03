class FeedEntry < ActiveRecord::Base
  #attr_accessible :guid, :name, :published_at, :summary, :url, :image
  
  def self.update_from_feed(feed_url)
    feed = Feedjira::Feed.fetch_and_parse(feed_url)
    feed.entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :name         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,
          :published_at => entry.published,
          :guid         => entry.id,
          :image        => entry.media_thumbnail_url
        )
      end
    end
  end
  
end
