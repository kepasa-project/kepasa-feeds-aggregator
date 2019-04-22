module Admin
	class CategoriesController < AdminBaseController

		layout "admin"
		
		before_action :set_category, only: [:show]

		def index
			@categories = Category.all.where(language: I18n.locale)
			@language = I18n.locale
		end

		def new
			@category = Category.new
		end

		def show

			@recommended_feeds = @category.recommended_feeds

		end

		def create

			@category = Category.new(category_params)

			if @category.save
				redirect_to admin_categories_path
			else
				render :new
			end

		end

		private

		def category_params
		  	params.require(:category).permit(:name, :language, :category_logo)
		end

		def set_category
			@category = Category.find(params[:id])
		end

	end
end