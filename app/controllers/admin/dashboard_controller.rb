module Admin
	class DashboardController < AdminBaseController

		layout "admin"
		
		before_action :authenticate_user!

		def index

			@categories = Category.all
			@recommended_feeds = RecommendedFeed.all
			
		end

	end
end