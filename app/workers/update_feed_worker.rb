class UpdateFeedWorker
   
  include Sidekiq::Worker

  sidekiq_options :queue => :default
  sidekiq_options :retry => false #when fail don't repeat
  
  require 'find_images'

  def perform(feed_id)

    Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
    Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
   
    @feed = Feed.find(feed_id)
    @user = @feed.user
    xml = HTTParty.get(@feed.rssurl).body

    begin
      feed = Feedjira.parse(xml)
    rescue Exception => exc
      logger.error("Message for the log file #{exc.message}")
      xml.force_encoding("UTF-8")
      feed = Feedjira.parse(xml)
    end

    feed.entries.each do |entry|  
      if entry.published.nil?
        @datafeedlist == Time.now()
      else  
        @datafeedlist = entry.published
      end

      unless Feedlist.where(:feed_id => @feed.id).exists? :guid => entry.id

        begin
          if FindImages.retrieve_image(entry.summary).nil?
            @object = LinkThumbnailer.generate(entry.url)
            @img_url = @object.images.last.to_s 
          else
          	@img_url = FindImages.retrieve_image(entry.summary)
          end
        rescue Exception => exc
          logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.id}")
          @img_url = entry.image
        end

        sleep 2
     
      @f = Feedlist.new(
           :rssurl       => @feed.rssurl,
           :name         => entry.title,
           :summary      => entry.summary,
           :url          => entry.url,    
           :published_at => @datafeedlist,
           :guid         => entry.id,
           :image        => entry.media_thumbnail_url,
           #:remote_article_picture_url => @img_url,
           :feed_id      => @feed.id,
           :user_id      => @user.id
           )
      end

      if @f.save    
        sleep = 1
        @f.update(:remote_article_picture_url => @img_url)
        sleep = 1
        logger.debug "Feedlist submitted ID: #{@f.id}"
        @object = nil
        @img_url = nil
      else
        next
      end
      
      sleep 1

    end
  end

  #def retrieve_image(summary)
  #  
  #@doc = Nokogiri::HTML(summary)
  #
  #@doc.css('img').each do |node|	  
  #  node.each do |attr,attr_val|
  #    if attr == "src"
  #     @attr_val = attr_val
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