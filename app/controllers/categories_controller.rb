class CategoriesController < ApplicationController

	before_action :set_category, only: [:show]

	def index
		current_language = Category.current_language
		@categories = Category.all.where(language: current_language)
		@language = current_language
	end

	def show

		@recommended_feeds = @category.recommended_feeds
        
	end

	private

	def category_params
	  	params.require(:category).permit(:name, :language, :category_logo, :recommended_feed_ids[])
	end

	def set_category
		@category = Category.find(params[:id])
	end

end