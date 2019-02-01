class FeedEntryController < ApplicationController
  
  def index

    if user_signed_in?

    @last_feeds = []
    @feeds = Feed.pluck(:rssurl).uniq     
    
        @feeds.each do |feed| 
        a = Feed.where(:rssurl => feed).last
        @last_feeds << a 
        end

    @last_feeds_paginate = Kaminari.paginate_array(@last_feeds.sort_by { |obj| obj.updated_at }.reverse).page(params[:page])

    @users = User.all 
    
    end

    
  end
  
  def content

    

  end

  def dashboard
    
    @feeds = current_user.feeds.order("created_at DESC").first(5)
    @feedlists = current_user.feedlists.order("published_at DESC").first(5)
    @bookmarks = current_user.bookmarks.order("created_at ASC").last(5)
    

    @tags = Feed.tag_counts_on(:tags)
  
  
  end
  
  
end
