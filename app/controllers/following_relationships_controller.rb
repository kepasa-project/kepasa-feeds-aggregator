class FollowingRelationshipsController < ApplicationController
  
  def create
    @user = User.find(params[:following_relationship][:followed_id])
    current_user.follow!(@user)
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = FollowingRelationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
