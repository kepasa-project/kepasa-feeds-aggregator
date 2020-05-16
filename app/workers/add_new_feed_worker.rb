class AddNewFeedWorker

  include Sidekiq::Worker

  sidekiq_options :queue => :default
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
      xml.force_encoding("UTF-8")
      feed = Feedjira.parse(xml)
    end	        
    
    #add last 10 news
    feed.entries.each do |entry|  

      entry.published.nil? ? @datafeedlist == Time.now() : @datafeedlist = entry.published

      #unless Feedlist.where(:feed_id => @feed.id).exists? :guid => entry.id
      unless Feedlist.where(:guid => entry.id).exists? :guid => entry.id

        begin
          if retrieve_image(entry.summary).nil?
            @object = LinkThumbnailer.generate(entry.url)
            @img_url = @object.images.last.to_s 
          else
            @img_url = retrieve_image(entry.summary)
          end
        rescue Exception => exc
          logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.id}")
          @img_url = entry.image
        end
				
        @f = Feedlist.new(
               :rssurl       => @feed.rssurl,
               :name         => entry.title,
               :summary      => entry.summary,
               :url          => entry.url,    
               :published_at => @datafeedlist,
               :guid         => entry.id,
               :image        => entry.media_thumbnail_url,
               :remote_article_picture_url => @img_url,
               #:remote_picture_url_location => @img_url,
               :content      => entry.content,
               :feed_id      => @feed.id,
               :user_id      => @user.id
             )
        
        @f.save
        
        sleep 2

      end
	  end

  end # end perform method
  
  #def retrieve_image(summary)
  #  
  #@doc = Nokogiri::HTML(summary)
  #
  #@doc.css('img').each do |node|    
  #  node.each do |attr,attr_val|
  #    if attr == "src"
  #      @attr_val = attr_val
  #    else
  #      @attr_val = nil
  #    end
  #  end
  #end
  #
  #return @attr_val
  #
  #end

end