class CategoriesController < ApplicationController

	def index
		@categories = Category.all.where(language: I18n.locale)
		@language = I18n.locale
	end

	private

	def category_params
	  params.require(:category).permit(:name, :language, :category_logo, :recommended_feed_ids[])
	end

end

