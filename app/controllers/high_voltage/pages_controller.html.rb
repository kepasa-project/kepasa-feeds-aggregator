class HighVoltage::PagesController < ApplicationController

=begin 
  def show
    #non so se questa action serve a qualcosa
    #@page = Page.find(params[:id])
    @user = current_user
    @newspapers = @user.newspapers.order("position")
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
    
  end
=end



end
    
    