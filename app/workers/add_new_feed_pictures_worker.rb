class AddNewFeedPicturesWorker

  include Sidekiq::Worker

  sidekiq_options :queue => :default
  sidekiq_options :retry => false #when fail don't repeat
  
  def perform(feed_id)       
    
    @f = Feedlist.find(feed_id)

    begin
      @object = LinkThumbnailer.generate(@f.url)
      @img_url = @object.images.last.to_s 
    rescue Exception => exc
      logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.id}")
      @img_url = @f.image
    end

    begin
      @f.update(:remote_article_picture_url => @img_url)
      @f.save!
    rescue Exception => exc
      logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.id}")
    end

  end # end perform method

end