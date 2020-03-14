class AddNewFeedWorker

  include Sidekiq::Worker
  sidekiq_options :retry => false #when fail don't repeat
  
  def perform(feed_id)       
  
    @feed = Feed.find(feed_id)
    @user = @feed.user

    Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
    Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
	            
    xml = HTTParty.get(@feed.rssurl).body

	begin	
      feed = Feedjira.parse(xml)	
    rescue Exception => exc
      logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.id}")
      # added follow line for ASCCI-8BIT error 
      puts "Message for the log file: #{exc.message} for the feed id: #{@feed.id}"
      xml.force_encoding("UTF-8")
      feed = Feedjira.parse(xml)
    end	        
      
    feed.entries.each do |entry|  

      entry.published.nil? ? @datafeedlist == Time.now() : @datafeedlist = entry.published

      #unless Feedlist.where(:feed_id => @feed.id).exists? :guid => entry.id
      unless Feedlist.where(:guid => entry.id).exists?

        begin
          @object = LinkThumbnailer.generate(entry.url)
          @img_url = @object.images.last.to_s 
        rescue Exception => exc
          logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.id}")
          @img_url = entry.image
        end 

        sleep 2
				
        Feedlist.create!(
          :rssurl       => @feed.rssurl,
          :name         => entry.title,
          :summary      => entry.summary,
          :url          => entry.url,    
          :published_at => @datafeedlist,
          :guid         => entry.id,
          :image        => entry.media_thumbnail_url,
          :remote_article_picture_url => @img_url,
          :content      => entry.content,
          :feed_id      => @feed.id,
          :user_id      => @user.id
        )
	  
	  end
	end

  end # end perform method

end