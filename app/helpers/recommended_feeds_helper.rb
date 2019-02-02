module RecommendedFeedsHelper

	def preview(feed)

		@feed = feed
		split_feed = @feed.split("/")

		link = split_feed[0] + "//" + split_feed[2]

		begin
		
			object = LinkThumbnailer.generate(link)
		
		rescue LinkThumbnailer::Exceptions => e
		 	
			puts e

		end

			return object

	end 


end
