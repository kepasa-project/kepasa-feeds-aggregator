class RelationshipsController < ApplicationController
  
  def new
    @relationship = Relationship.new
    @newspapers = Newspaper.all
    @page = Page.new
    #la seguente riga e' la barra di navigazione
    @nav = true
  end

  def create
    @relationship = Relationship.new(params[:relationship])
    
    if @relationship.save
      
      redirect_to root_path
      
    else
    
      render 'new'
    
    end
  end

  def destroy
  end
end
