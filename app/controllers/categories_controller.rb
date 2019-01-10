class CategoriesController < InheritedResources::Base

  private

    def category_params
      params.require(:category).permit(:name, :language, :category_logo)
    end
end

