module Admin
	class RecommendedFeedsController < ApplicationController

		def create
		    @recommended_feed = RecommendedFeed.new(params[:recommended_feed])
		  	
		  	if @recommended_feed.save
		  		
		      split_recommended_feed = @recommended_feed.rssurl.split("/")

		      link = split_recommended_feed[0] + "//" + split_recommended_feed[2]

		    begin
		    
		      object = LinkThumbnailer.generate(link)
		      
		      @recommended_feed.update(logo: object.images.first.src.to_s, title: object.title, description: object.description)

		    rescue LinkThumbnailer::Exceptions => e
		      
		      puts e

		    end

		  	else
		  		render :new
		  	end
		end
		
	end
end