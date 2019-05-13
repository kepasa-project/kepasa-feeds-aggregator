require 'link_thumbnailer'

if User.where(username: 'Reader', email: 'reader@kepasa.mx').blank?

  User.create(username: 'Reader', email: 'reader@kepasa.mx', password: "password", password_confirmation: "password")

end

Feed.where(rssurl: 'https://www.wired.com/feed/category/science/latest/rss', description: "Wired Description", title: 'Science Tech', user_id: 1).first_or_create

puts 'Created the First User and the First Feed'

if File.exists?("#{Rails.root}/lib/personal_feeds.txt")

	puts 'Creating ... populate Personal Feeds table' 

	Feed.delete_all
	open("#{Rails.root}/lib/personal_feeds.txt") do |feed|
		feed.read.each_line do |data|
	  		rssurl, user_id, title = data.chomp.split("|")
	    	Feed.create!(:rssurl => rssurl, :user_id => user_id, :title => title)
	  	end
	end

end

puts 'Creating ... populate Categories table'

Category.delete_all
open("#{Rails.root}/lib/categories.txt") do |category|
	category.read.each_line do |data|
  		name, image, language = data.chomp.split("|")
    	image_src = "#{Rails.root}/app/assets/images/categories/#{image}.jpg"
    	src_file = File.new(image_src)
    	category = Category.create(:name => name, :category_logo => src_file, :language => language)
  		puts "Created #{name} Category"
  	end
end

puts 'Creating ... populate Recommended Feeds table'

RecommendedFeed.delete_all
open("#{Rails.root}/lib/recommended_feeds.txt") do |recommended_feed|
	recommended_feed.read.each_line do |data|
  		title, image, rssurl, category_name, tag_list = data.chomp.split("|")
  		category = Category.find_by_name(category_name)
  		image_src = "#{Rails.root}/app/assets/images/recommended_feeds/#{image}.jpg"
  		src_file = File.new(image_src)
  		recommended_feed = RecommendedFeed.create(:rssurl => rssurl, :logo => src_file, category_ids: category.id)
  		puts "Created #{title} Recommended Feed"    	
  	end
end