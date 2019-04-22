class BookmarksController < ApplicationController
  # GET /bookmarks
  # GET /bookmarks.json
  
  def tagged

    @user = current_user

    @bookmarks = @user.bookmarks.page(params[:page])
    
    if params[:tag].present? 

      @usertags = @bookmarks.tagged_with(params[:tag])

    else 

      @usertags = @bookmarks.all

    end
  
  end
  
  def index
    @user = current_user
    @bookmarks = @user.bookmarks.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bookmarks }
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bookmark }
    end
  end

  def new
    @user = current_user
    @bookmark = Bookmark.new(:url => params[:url], :title => params[:title])
  
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bookmark }
    end

  end

  # GET /bookmarks/1/edit
  def edit
    @user = current_user
    @bookmark = Bookmark.find(params[:id])
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def createx
    @user = current_user
    @bookmark = Bookmark.new(params[:bookmark])

    if @bookmark.save
     redirect_to(root_path, :notice => 'Bookmark was successfully created.')
    else
     render action: "new" 
      
    end

  end

  # PUT /bookmarks/1
  # PUT /bookmarks/1.json
  def update
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        format.html { redirect_to user_bookmarks_path, notice: 'Bookmark was successfully updated.'}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @page = Page.find(params[:id])
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to page_path(@page) }
      format.json { head :no_content }
    end
  end
end