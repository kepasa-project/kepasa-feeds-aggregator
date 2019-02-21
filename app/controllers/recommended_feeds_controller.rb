class RecommendedFeedsController < ApplicationController
  
  def index
  	@category = Category.find(params[:category_id])
  	@recommended_feeds = @category.recommended_feeds

  end

  def new

    @recommended_feed = RecommendedFeed.new
  end
#=begin

  def create
    @recommended_feed = RecommendedFeed.new(recommended_feed_params)
  	
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

#=end

  private

    def recommended_feed_params
      params.require(:recommended_feed).permit(:rssurl, :title, :logo, :descripction, category_ids: [])
    end
end

