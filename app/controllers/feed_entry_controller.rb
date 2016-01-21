class FeedEntryController < ApplicationController
  
  def index

    if user_signed_in?

    @last_feeds = []
    @feeds = Feed.pluck(:rssurl).uniq     
    
    @feeds.each do |feed| 
    a = Feed.where(:rssurl => feed).last
    @last_feeds << a 
    end

    @last_feeds_paginate = Kaminari.paginate_array(@last_feeds.sort_by { |obj| obj.updated_at }.reverse).page(params[:page]).per(5)

=begin   

    @user = current_user

    @feeds_current_user = @user.feeds

    #User.find_each do |user|

        @feeds_current_user.find_each(:batch_size => 200) do |feed|

            NoticiasElpaisWorker.perform_async(feed.id.to_i)

            sleep 5

        end
        #end
=end

    @users = User.all 
    
    else
    
    #@news = New.offset(rand(New.count)).limit(7)
    #@news = Feedlist.find(:all, :order => "created_at DESC", :limit => 5)

    end  

    
  end
  
  
  
end
