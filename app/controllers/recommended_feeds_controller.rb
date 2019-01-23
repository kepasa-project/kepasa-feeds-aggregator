class RecommendedFeedsController < ApplicationController
  
  def index
  	@category = Category.find(params[:category_id])
  	@recommended_feeds = @category.recommended_feeds
  end

  private

    def recommended_feed_params
      params.require(:recommended_feed).permit(:rssurl, :title, category_ids: [])
    end
end

