class FeedsController < ApplicationController
  before_filter :set_feed, only: [:show, :edit, :update, :destroy]
   
  respond_to :html, :xml, :json
  
  require 'nokogiri'
  require 'open-uri'
  
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

    @user = User.find(params[:user_id])
    #@feeds = Feed.all
    @feeds = @user.feeds.page(params[:page])
    respond_with(@user, @feeds)
  end

  def show
    #User.find_by_username()
    auxvar = 'ciao'
    @user = User.find(params[:user_id])
    @feeds = @user.feeds
    @feed = Feed.find(params[:id])
    @feedlists = @feed.feedlists.page(params[:page])

=begin
    @feedlists.each do |feedlist|
      Feedlist.usuario(@user.id, @feed.rssurl)
      Feedlist.update_from_feed(feedlist.rssurl)
    end
=end
    respond_with(@feed)
  end

  def new

    @user = current_user
    @feed = Feed.new(:user_id => @user.id, :rssurl => params[:rssurl])
    
    respond_with(@feed)
  end

  def edit
  end

  def create
    #@user = User.find(params[:user_id])
    @user = current_user
    @feed = Feed.new(params[:feed])

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
                                :feed_id      => @feed.id
                              )
                        end
                      end 
                    
                    redirect_to user_feeds_path(current_user)

                    else

                      render 'new', :notice => "Algo malo paso, prueba otra vez!"

                    end

            else

              redirect_to new_user_feed_path, :alert => "No puede dejar vacio el campo o insertar un feed ya presente o poner un feed incorrecto!"

            end # close if @feed.valid?
        
  end

  def update
    @user = current_user
    flash[:notice] = 'Feed was successfully updated.' if @feed.update_attributes(params[:feed])
    respond_with(@user, @feed)
  end

  def destroy
    @feedlists = Feedlist.where(:feed_id => @feed.id)
    @feedlists.delete_all
    @feed.destroy
    redirect_to user_feeds_path(current_user)
  end

  private
    def set_feed
      @feed = Feed.find(params[:id])
    end
end
