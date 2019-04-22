module Admin
	class DashboardController < AdminBaseController

		layout "admin"

		def index

			@categories = Category.all
			@recommended_feeds = RecommendedFeed.all
			
		end

	end
end