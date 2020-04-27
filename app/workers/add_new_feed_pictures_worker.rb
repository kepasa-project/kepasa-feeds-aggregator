class AddNewFeedPicturesWorker

  include Sidekiq::Worker

  sidekiq_options :queue => :default
  sidekiq_options :retry => true #when fail don't repeat

  def perform(feedlist_id)       
    
    @f = Feedlist.find(feedlist_id)
    @img_url = @f.remote_picture_url_location
    @name_file = @img_url.to_s.split('/')[-1]
    @feed = @f.feed 
    
    #begin 
    #  @uri = URI.parse(@img_url)
    #rescue URI::InvalidURIError
    #  @uri = URI.parse(URI.escape(@img_url))
    #end

    begin
      a = Rails.root + "app/assets/images/feeds"
      path = "#{a}/#{@feed.id}/feedlist-#{@f.id}/"
      system 'mkdir', '-p', path
      #Dir.mkdir("#{path}") #unless File.exists?("#{path}")
      #download = open("#{@img_url}")
      #IO.copy_stream(download, "#{a}/#{@feed.id}/feedlist-#{@f.id}/#{download.base_uri.to_s.split('/')[-1]}")
      image = MiniMagick::Image.open("#{@img_url}")
      image.contrast
      image.write("#{a}/#{@feed.id}/feedlist-#{@f.id}/#{@img_url.to_s.split('/')[-1]}")
    rescue Exception => exc
      logger.error("Message for the log file: #{exc.message} to create thumbnail directory: #{@f.id}")
    end 

  end # end perform method

end