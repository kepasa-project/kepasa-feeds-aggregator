class UpdateAllFeedsWorker

  include Sidekiq::Worker

  sidekiq_options :queue => :default
  sidekiq_options :retry => false #when fail don't repeat
  
  def logger
    Logger.new("log/sidekiq-update-all-feeds-worker.log")
  end

  def perform(user_id)
    
    logger.info "Perform Update All Feeds"

    Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
    Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)

    @user = User.find(user_id)

    @user.feeds.find_each do |feed|

      @feed_update = feed
      xml = HTTParty.get(@feed_update.rssurl.to_s).body

      begin
        @feed = Feedjira.parse(xml)
      rescue Exception => exc
        next if exc.message == "No valid parser for XML."
        logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed_update.id}")
        # added follow line for ASCCI-8BIT error 
        xml.force_encoding("UTF-8")
        @feed = Feedjira.parse(xml)
      end	        
      
      logger.debug "Feed #{@feed_update.inspect}"
      unless @feed.is_a?(Fixnum) #HTTP fetch results is not an error (i.e. not a 200 or 3XX)
        

        @feed.entries.each do |entry|  

          entry.published.nil? ? @datafeedlist = Time.now() : @datafeedlist = entry.published
          
          if @feed_update.feedlists.find_by(:guid => entry.id).nil?
             
            logger.debug "Feedlist #{entry.url}"
            begin
              if retrieve_image(entry.summary).nil?
                @object = LinkThumbnailer.generate(entry.url)
                @img_url = @object.images.last.to_s 
              else
                @img_url = retrieve_image(entry.summary)
              end
            rescue Exception => exc
              logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.inspect}")
              @img_url = entry.image
            end
    			  
            logger.debug "Image #{@img_url.inspect}"
            @feedlist = Feedlist.create!(
                         :rssurl       => @feed_update.rssurl,
                         :name         => entry.title.to_s.force_encoding("UTF-8"),
                         :summary      => entry.summary.to_s.force_encoding("UTF-8"),
                         :url          => entry.url,    
                         :published_at => @datafeedlist,
                         :guid         => entry.id,
                         :content 		  => entry.content,
                         :image        => entry.media_thumbnail_url,
                         :remote_article_picture_url => @img_url,
                         :feed_id      => @feed_update.id,
                         :user_id      => @user.id
                       )
            
          end
          
          logger.debug "Feedlist submitted ID: "
      
          sleep = 2
          @object = nil
          @img_url = nil
        end
      end #end unless HTTP fetch status
      
	  end #end feeds loops

  end # end perfom method
  
  # method to retrieve image maybe it's better removed it
  #def retrieve_image(summary)
  #  
  #  @doc = Nokogiri::HTML(summary)
  #    
  #    @doc.css('img').each do |node|
	#      node.each do |attr,attr_val|
	#        if attr == "src"
	#          @attr_val = attr_val
	#        end
	#      end
	#    end
  #  
  #  return @attr_val
  #
  #end

end