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

	def check_thumbnail(category)

		@category = category

		begin 

			image_tag(@category.category_logo.url(:thumb)).html_safe

			#puts "brubbolo" 

		rescue  # == "Version thumb doesn't exist!"

			image_tag(@category.category_logo, size: "100x50").html_safe
			
			#puts "cIOA"
		
		end

	end

end