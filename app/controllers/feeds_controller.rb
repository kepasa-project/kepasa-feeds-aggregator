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

    @user = current_user
    @feed = Feed.new(feed_params)

          #if @feed.valid? && Feedjira::Feed.fetch_and_parse(@feed.rssurl) != nil
          if @feed.valid?

          # in the following line add like User Agent Firefox to fix the error: OpenURI::HTTPError: 403 Forbidden  
          doc = Nokogiri::XML(open(@feed.rssurl, 'User-Agent' => 'firefox')) 
          #@feed.title = doc.at_xpath('/rss/channel/title').inner_text
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

  def update
    @user = current_user
    flash[:notice] = 'Feed was successfully updated.' if @feed.update(feed_params)
    redirect_to user_feed_path(@user, @feed)
  end

  def update_all_feeds

    UpdateAllFeedsWorker.perform_async(current_user.id)
    #UpdateAllFeedsJob.perform_later(current_user)
    #redirect_to("/#{I18n.locale}/" + root_path)
    redirect_to root_path

  end

  def actualiza
    @feed = Feed.find(params[:id].to_i)
    UpdateFeedWorker.perform_async(@feed.id)
    redirect_to([current_user, @feed])
  end

  def destroy
    @feedlists = Feedlist.where(:feed_id => @feed.id)
    @feedlists.delete_all
    @feed.destroy
    redirect_to user_feeds_path(current_user)
  end

  private

    def feed_params
      params.require(:feed).permit(:rssurl, :title, :tag_list, :user_id)
    end

    def set_feed
      @feed = Feed.find(params[:id])
    end
    
end