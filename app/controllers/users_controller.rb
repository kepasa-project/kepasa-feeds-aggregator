class UsersController < ApplicationController
  
	def show
	end

	def index

		@users = User.order("created_at DESC").page(params[:page])

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
