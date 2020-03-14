class FeedlistsController < ApplicationController

  before_action :set_feedlist, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:show]

  def index

    @feedlists = current_user.feedlists.order("published_at DESC").paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.js
    end

  end

  def show

    begin

      @object = LinkThumbnailer.generate(@feedlist.url)

      @img_url = @object.images.last.to_s 
      @url = @feedlist.url
      @preview = Onebox.preview(@url)

    rescue

      @img_url = @feedlist.image
      
    end 

    @user = current_user
    
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

  def tagged

    list_feed_id = current_user.feeds.tagged_with(params[:tag]).pluck(:id)

    @feedlists = Feedlist.where(feed_id: list_feed_id).order("published_at DESC").paginate(page: params[:page], per_page: 5)
  end

  def search

    @feedlists = current_user.feedlists.order("published_at DESC").search(params[:term]).paginate(page: params[:page])

  end

  private
    def set_feedlist
      @feedlist = Feedlist.find(params[:id])
    end
end