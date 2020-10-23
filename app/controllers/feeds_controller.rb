class FeedsController < ApplicationController

  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  
  require 'nokogiri'
  require 'open-uri'
  require 'openssl' # DO NOT USE A LOCAL CERTIFICATE
  
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
          doc = Nokogiri::XML(open(@feed.rssurl, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE, 'User-Agent' => 'firefox')) 
          @feed.title = doc.xpath('/rss/channel/title').inner_text

                    if @feed.save 
                    
                      AddNewFeedWorker.perform_async(@feed.id)            
                           
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
    #AddNewFeedWorker.perform_async(@feed.id)            
    #AddNewFeedWorker.perform_in(1.seconds, @feed.id)                
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

    #current_user.feeds.find_each do |feed|
    #  
    #  UpdateFeedWorker.perform_async(feed.id)
    #  
    #  sleep 1
    #
    #end
    
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