module Admin
	class CategoriesController < AdminBaseController

		before_action :set_category, only: [:show]

		def index
			@categories = Category.all.where(language: I18n.locale)
			@language = I18n.locale
		end

		def show

			@recommended_feeds = @category.recommended_feeds

		end

		def create

		end

		private

		def category_params
		  	params.require(:category).permit(:name, :language, :category_logo, :recommended_feed_ids[])
		end

		def set_category
			@category = Category.find(params[:id])
		end

	end
end