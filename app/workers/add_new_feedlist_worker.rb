class AddNewFeedlistWorker

  include Sidekiq::Worker

  sidekiq_options :queue => :default
  sidekiq_options :retry => false #when fail don't repeat

    def perform(entry, feed_update)
      
      @feed_update = feed_update
      entry = entry
      @user = @feed_update.user

      entry.published.nil? ? @datafeedlist = Time.now() : @datafeedlist = entry.published
      
      puts "#{entry}"
      
          if @feed_update.feedlists.find_by(:guid => entry.id).nil?
             
            logger.debug "Feedlist #{entry.url}"
            begin
              if FindImages.retrieve_image(entry.summary).nil?
                @object = LinkThumbnailer.generate(entry.url)
                @img_url = @object.images.last.to_s 
              else
                @img_url = FindImages.retrieve_image(entry.summary)
              end
            rescue Exception => exc
              logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.inspect}")
              @img_url = entry.image
            end
            
            logger.debug "Image #{@img_url.inspect}"
            @feedlist = Feedlist.new(
                         :rssurl       => @feed_update.rssurl,
                         :name         => entry.title.to_s.force_encoding("UTF-8"),
                         :summary      => entry.summary.to_s.force_encoding("UTF-8"),
                         :url          => entry.url,    
                         :published_at => @datafeedlist,
                         :guid         => entry.id,
                         :content       => entry.content,
                         :image        => entry.media_thumbnail_url,
                         :remote_article_picture_url => @img_url,
                         :feed_id      => @feed_update.id,
                         :user_id      => @user.id
                       )
            
            if @feedlist.save    
              sleep = 2      
              logger.debug "Feedlist submitted ID: "
              @object = nil
              @img_url = nil
            else
              next
            end

          end

    end

end