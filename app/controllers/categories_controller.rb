class CategoriesController < InheritedResources::Base

  private

    def category_params
      params.require(:category).permit(:name, :language, :category_logo, :recommended_feed_ids[])
    end
end

