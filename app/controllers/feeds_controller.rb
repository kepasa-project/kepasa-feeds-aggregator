class FeedsController < ApplicationController

  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  
  require 'nokogiri'
  require 'open-uri'
  
  def tag_cloud
    @tags = Feed.tag_counts_on(:tags)
  end

  def tagged_feed

    @user = current_user
    @feeds = Feed.all
    
    if params[:tag].present? 
      @tag = params[:tag]
      @feed_tags = @user.feeds.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else 
      @feed_tags = Feed.all
    end

  end
  
  def index
    @user = current_user
    @feeds = current_user.feeds.paginate(page: params[:page])
  end

  def show
    @feed = Feed.find(params[:id])
    @feedlists = @feed.feedlists.order('published_at DESC').paginate(page: params[:page])
  end

  def new
    @user = current_user
    @feed = Feed.new(:user_id => @user.id, :rssurl => params[:rssurl])
  end

  def edit
  end

  def create

    feed_params.each { |key, value| value.strip! }
    @user = current_user
    @feed = Feed.new(feed_params)
          #if @feed.valid? && Feedjira::Feed.fetch_and_parse(@feed.rssurl) != nil
          if @feed.valid?

          # in the following line add like User Agent Firefox to fix the error: OpenURI::HTTPError: 403 Forbidden  
          doc = Nokogiri::XML(open(@feed.rssurl, 'User-Agent' => 'firefox')) 
          #@feed.title = doc.at_xpath('/rss/channel/title').inner_text
          @feed.title = doc.xpath('/rss/channel/title').inner_text

                    if @feed.save 
                    
                      #AddNewFeedWorker.perform_async(@feed.id)            
#########inizio

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
               :content      => entry.content,
               :feed_id      => @feed.id,
               :user_id      => @user.id
             )
        
        begin
          @f.remote_article_picture_url = @img_url
          @f.save!
        rescue Exception => exc
          logger.error("Message for the log file: #{exc.message} for the feed id: #{@feed.id}")
        end 

        #store picture
        unless @img_url.nil?
          begin
          a = Rails.root + "pictures/thumbnails"
          path = "#{a}/feed-#{@feed.id}/#{@f.id}/"
          system 'mkdir', '-p', path
          #Dir.mkdir("#{path}") #unless File.exists?("#{path}")
          download = open("#{@img_url}")
          IO.copy_stream(download, "#{a}/feed-#{@feed.id}/#{@f.id}/#{download.base_uri.to_s.split('/')[-1]}")
          rescue Exception => exc
            logger.error("Message for the log file: #{exc.message} to create thumbnail directory: #{@f.id}")
          end 
        end

      end
    end
####### fine
                      redirect_to root_path

                    else

                      render 'new', :notice => "Algo malo paso, prueba otra vez!"

                    end

            else

              #redirect_to new_user_feed_path, :alert => "No puedes insertar un feed ya presente o poner un feed incorrecto!"
              redirect_to new_user_feed_path, :alert => t(:feed_message_error)

            end # close if @feed.valid?
        
  end
  
  def add_feed
    
    #feed_params.each { |key, value| value.strip! }
    @feed = Feed.new(feed_params)
    @feed.save
    AddNewFeedWorker.perform_async(@feed.id)            
    category = Category.find(params[:category])
    
    redirect_to category_path(category)

  end

  def update
    @user = current_user
    flash[:notice] = 'Feed was successfully updated.' if @feed.update(feed_params)
    redirect_to user_feed_path(@user, @feed)
  end

  def update_all_feeds

    UpdateAllFeedsWorker.perform_async(current_user.id)
    redirect_to user_feeds_path(current_user)

  end

  def actualiza
    @feed = Feed.find(params[:id].to_i)
    UpdateFeedWorker.perform_async(@feed.id)
    redirect_to([current_user, @feed])
  end

  def destroy
    
    redirect_to user_feeds_path(current_user)
    FeedDeleteWorker.perform_async(@feed.id)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

    def feed_params
      params.require(:feed).permit(:rssurl, :title, :tag_list, :user_id)
    end

    def set_feed
      @feed = Feed.find(params[:id])
    end
    
end