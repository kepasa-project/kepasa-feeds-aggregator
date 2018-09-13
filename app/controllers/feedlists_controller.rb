class FeedlistsController < ApplicationController

  before_action :set_feedlist, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:show]

  def index

    @feed = Feed.find(params[:feed_id])
    @feedlists = @feed.feedlists.order("published_at ASC")
    #@feedlists = Feedlist.all
    respond_with(@feedlists)
  end

  def show
     @user = current_user
    #@feedlist = Feedlist.find(params[:id])
    unless user_signed_in?
      cookies[:omniauth] = feedlist_url(@feedlist)
    end
    respond_with(@feedlist)
  end

  def new
    @feedlist = Feedlist.new
    respond_with(@feedlist)
  end

  def edit
  end

  def create
    @feed = Feed.find(params[:user_id])
    @feedlist = Feedlist.new(params[:feedlist])
    flash[:notice] = 'Feedlist was successfully created.' if @feedlist.save
    if current_user
    User.share_review(current_user.id, feedlist_url(@feedlist))
    end
    respond_with(@feedlist)
  end

  def update
    flash[:notice] = 'Feedlist was successfully updated.' if @feedlist.update_attributes(params[:feedlist])
    respond_with(@feedlist)
  end

  def destroy
    @user = current_user
    @feedlist.destroy
    respond_with(@user)
  end
  
  def actualiza

   Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
   Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
   
   #@user = User.find(params[:user_id])
   @user = current_user
   
   @feed = Feed.find(params[:id])

   feed = Feedjira::Feed.fetch_and_parse(@feed.rssurl)
    
    feed.entries.each do |entry|  

      if entry.published.nil?

        @datafeedlist == Time.now()

       else
       
       @datafeedlist = entry.published
      
      end

      unless Feedlist.where(:feed_id => @feed.id).exists? :guid => entry.id

            Feedlist.create!(
              :rssurl       => @feed.rssurl,
              :name         => entry.title,
              :summary      => entry.summary,
              :url          => entry.url,    
              :published_at => @datafeedlist,
              :guid         => entry.id,
              :image        => entry.media_thumbnail_url,
              :feed_id      => @feed.id
            )
      end
    end 

   redirect_to([@user, @feed])
  end

  private
    def set_feedlist
      @feedlist = Feedlist.find(params[:id])
    end
end
