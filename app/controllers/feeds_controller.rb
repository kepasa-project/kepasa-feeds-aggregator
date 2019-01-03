class FeedsController < ApplicationController

  before_action :set_feed, only: [:show, :edit, :update, :destroy]
   
  #respond_to :html, :xml, :json
  
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

      @feed_tags = Feed.tagged_with(params[:tag]).page(params[:page])

    else 

      @feed_tags = Feed.all

    end

    
  end
  
  def index
    @user = current_user
    @feeds = current_user.feeds.page(params[:page])
  
  end

  def show
    #User.find_by_username()
    auxvar = 'ciao'
    #@user = User.find(params[:user_id])
    
    @feeds = current_user.feeds
    @feed = Feed.find(params[:id])
    @feedlists = @feed.feedlists.page(params[:page])

  end

  def new

    @user = current_user
    @feed = Feed.new(:user_id => @user.id, :rssurl => params[:rssurl])
    
    #respond_with(@feed)
  end

  def edit
  end

  def create

    @user = current_user
    @feed = Feed.new(feed_params)

          if @feed.valid?    
            
          # in the following line add like User Agent Firefox to fix the error: OpenURI::HTTPError: 403 Forbidden  
          doc = Nokogiri::XML(open(@feed.rssurl, 'User-Agent' => 'firefox')) 
          #@feed.title = doc.at_xpath('/rss/channel/title').inner_text
          @feed.title = doc.xpath('/rss/channel/title').inner_text

                    if @feed.save
                    
                     Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
                     Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
                     
                     #@user = current_user
                     #@feed = Feed.find(params[:id])

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
                                :content      => entry.content,
                                :feed_id      => @feed.id,
                                :user_id      => @user.id
                              )
                        end
                      end 
                    
                    redirect_to root_path

                    else

                      render 'new', :notice => "Algo malo paso, prueba otra vez!"

                    end

            else

              redirect_to new_user_feed_path, :alert => "No puede dejar vacio el campo o insertar un feed ya presente o poner un feed incorrecto!"

            end # close if @feed.valid?
        
  end

  def update
    @user = current_user
    flash[:notice] = 'Feed was successfully updated.' if @feed.update(feed_params)
    redirect_to user_feed_path(@user, @feed)
  end

  def update_all_feeds

    #UpdatefeedsWorker.perform_async(current_user.id)
    UpdateAllFeedsJob.perform_later(current_user)
    redirect_to("/#{I18n.locale}/" + root_path)

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