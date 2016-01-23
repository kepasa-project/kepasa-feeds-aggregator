class UsersController < ApplicationController
  
	def show

		@user = User.find(params[:id])
		@title = @user.username
    @feed_items = @user.feed

    # snippet added to update current user rss feeds 
    @feeds_current_user = @user.feeds

    @feeds_current_user.find_each(:batch_size => 200) do |feed|

        NoticiasElpaisWorker.perform_async(feed.id.to_i)

        #sleep 5

    end
    # end snippet 
    
	end

	def index

		@users = User.order("created_at DESC").page(params[:page])
    #@users_paginate = @users.page(params[:page])

	end

	def following
      @title = "Following"
      @user = User.find(params[:id])
      @users = @user.following
      #@users = @user.following.page(params[:page])
      render 'show_follow'
  end

  def followers
      @title = "Followers"
      @user = User.find(params[:id])
      @users = @user.followers
      #@users = @user.followers.page(params[:page])
      render 'show_follow'
  end

  def empty_trash
    current_user.trash.each do |conversation|
      conversation.receipts_for(current_user.id).update_all(deleted: true)
    end
    flash[:success] = 'Ahora la basura esta limpia!'
    redirect_to conversations_path
  end

end
