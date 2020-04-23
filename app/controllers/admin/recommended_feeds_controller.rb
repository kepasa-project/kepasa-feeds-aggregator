module Admin
	class RecommendedFeedsController < AdminBaseController

		layout "admin"
		
		before_action :set_recommended_feed, only: [:show, :edit, :update, :destroy]
		before_action :authenticate_user!

		def index

			@recommended_feeds = RecommendedFeed.all
		
		end

		def new

			@recommended_feed = RecommendedFeed.new

		end

		def edit

		end

		def show
			@recommended_feed = RecommendedFeed.find(params[:id])
		end

		def create
		    
		  	@recommended_feed = RecommendedFeed.new(params[:recommended_feed].permit!)

		  	if @recommended_feed.save

			  redirect_to root_path

		  	else
		  	  render :new
		  	end
		
		end
		
		def destroy

			respond_to do |format|
				if @recommended_feed.destroy
					format.html {redirect_to request.referrer, notice: 'Recommended Feed was successfully deleted.'}
	        		format.json { head :no_content }
	      		else
	        		format.html { render action: "edit" }
	        		format.json { render json: @recommended_feed.errors, status: :unprocessable_entity }
	      		end
	    	end

		end

		def update

			respond_to do |format|
				if @recommended_feed.update(params[:recommended_feed].permit!)
					format.html { redirect_to admin_recommended_feeds_path, notice: 'Category was successfully updated.'}
	        		format.json { head :no_content }
	      		else
	        		format.html { render action: "edit" }
	        		format.json { render json: @recommended_feed.errors, status: :unprocessable_entity }
	      		end
			end
		
		end

		private

		def set_recommended_feed
			@recommended_feed = RecommendedFeed.find(params[:id])
		end

		def recommended_feed_params
      		params.require(:recommended_feed).permit(:rssurl, :title, :description, :logo, :tag_list, :category_ids[])
    	end

	end
end