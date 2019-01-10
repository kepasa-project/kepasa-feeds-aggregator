class RecommendedFeedsController < InheritedResources::Base

  private

    def recommended_feed_params
      params.require(:recommended_feed).permit(:rssurl, :title, :category_id)
    end
end

