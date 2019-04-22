module Admin
	class RecommendedFeedsController < AdminBaseController

		layout "admin"
		
		def index

			#@category = Category.find(params[:category_id])
			#@recommended_feeds = @category.recommended_feeds
			@recommended_feeds = RecommendedFeed.all
		
		end

		def new

			#@category = Category.find(params[:category_id])
			@recommended_feed = RecommendedFeed.new

		end

		def show
			@recommended_feed = RecommendedFeed.find(params[:id])
		end

		def create
		    
		    #byebug
		    #@recommended_feed = RecommendedFeed.new(recommended_feed_params)
		  	@recommended_feed = RecommendedFeed.new(params[:recommended_feed].permit!)

		  	if @recommended_feed.save
=begin
		      split_recommended_feed = @recommended_feed.rssurl.split("/")

		      link = split_recommended_feed[0] + "//" + split_recommended_feed[2]

				    begin
				    
				      #object = LinkThumbnailer.generate(link)
				      page = MetaInspector.new(link)
				      
				      #@recommended_feed.update(logo: object.images.first.src.to_s, title: object.title, description: object.description)
				      @recommended_feed.update(logo: page.images.best, title: object.title, description: object.description)
				    
				    rescue MetaInspector::Exceptions => e
				      
				      puts e

				    end
=end
			redirect_to root_path

		  	else
		  		render :new
		  	end
		end
		
		private

		def set_recommended_feed
			RecommendedFeed.find(params[:id])
		end

		def recommended_feed_params
      		params.require(:recommended_feed).permit(:rssurl, :title, :description, :logo, :tag_list, :category_ids[])
    	end

	end
end