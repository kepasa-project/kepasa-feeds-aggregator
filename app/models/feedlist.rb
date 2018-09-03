class Feedlist < ActiveRecord::Base
  
  paginates_per 5
  
  #attr_accessible :feed_id, :guid, :image, :name, :published_at, :rssurl, :summary, :url, :content
  
  belongs_to :feed, :touch => true
  
  #default_scope :order => 'published_at ASC'

  def self.usuario(user, rssurl)
  
  @feed = Feed.where(:user_id => user.to_i, :rssurl => rssurl.to_s).last

  end
  
  def self.update_from_feed(feed_url)
    
    Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
    Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
    
    feed = Feedjira::Feed.fetch_and_parse(feed_url)
    
    unless feeds.is_a?(Fixnum)

        feed.entries.each do |entry|  

            if entry.published.nil?

                @datafeedlist == Time.now()

               else
               
               @datafeedlist = entry.published
            
            end

            if exists? :guid => entry.id

                  create!(
                    :rssurl       => feed.rssurl,
                    :name         => entry.title,
                    :summary      => entry.summary,
                    :url          => entry.url,    
                    :published_at => @datafeedlist,
                    :guid         => entry.id,
                    :image        => entry.media_thumbnail_url,
                    :feed_id      => @feed.id
                  )
            end
      
        end

      else

        redirect_to root_path #ciao

      end
      
  end # close update_from_feed method
    
end
