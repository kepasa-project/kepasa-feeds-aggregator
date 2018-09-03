class New < ActiveRecord::Base
  
  #require 'Feedjira'
  
  #attr_accessible :guid, :image, :name, :newspaper_id, :published_at, :summary, :url, :rssurl
  
  belongs_to :newspaper
  
  #default_scope :order => 'news.published_at DESC'

  def self.update_from_feed(feedurl)
    
    Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
    Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
    
    feed = Feedjira::Feed.fetch_and_parse(feedurl)
#=begin    
    #check = feed.last_modified.nil? 
    
    feed.entries.each do |entry|  
      
        if entry.published.nil? == true && feed.last_modified.nil? == false
        
        @datafeed == feed.last_modified
        
        elsif entry.published.nil? == false && feed.last_modified.nil? == true
        
        @datafeed == entry.published
        
        elsif entry.published.nil? == false && feed.last_modified.nil? == false

        @datafeed == entry.published
        
        else
          
        @datafeed == Time.now()
        
        end

    end
#=end
    feed.entries.each do |entry|
      unless exists? :guid => entry.id
        create!(
          :rssurl       => feedurl,
          :name         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,
          :published_at => @datafeed,
          :guid         => entry.id,
          :image        => entry.media_thumbnail_url
        )
      end
    end
  end
  
end
