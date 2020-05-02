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
      unless Feedlist.where(:guid => entry.id).exists?

        begin
          @object = LinkThumbnailer.generate(entry.url)
          @img_url = @object.images.last.to_s 
        rescue Exception => exc
          logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.id}")
          @img_url = entry.image
        end 

        sleep 2
				
        @f = Feedlist.create!(
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
        
        if Rails.env = "production"
          MoveFeedlistImagesWorker.new.perform(@f.id)
        end
        #AddNewFeedPicturesWorker.new.perform(@f.id)

        #store picture
        #unless @img_url.nil?
        #  begin
        #  a = Rails.root + "pictures/thumbnails"
        #  path = "#{a}/feed-#{@feed.id}/#{@f.id}/"
        #  system 'mkdir', '-p', path
        #  #Dir.mkdir("#{path}") #unless File.exists?("#{path}")
        #  download = open("#{@img_url}")
        #  IO.copy_stream(download, "#{a}/feed-#{@feed.id}/#{@f.id}/#{download.base_uri.to_s.split('/')[-1]}")
	      #  rescue Exception => exc
        #    logger.error("Message for the log file: #{exc.message} to create thumbnail directory: #{@f.id}")
        #  end
        #end

      end
	  end

  end # end perform method

end