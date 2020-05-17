require 'link_thumbnailer'

if User.where(username: 'Reader', email: 'reader@kepasa.mx').blank?

  User.create(username: 'Reader', email: 'reader@kepasa.mx', password: "password", password_confirmation: "password")

end

Feed.where(rssurl: 'https://www.wired.com/feed/category/science/latest/rss', description: "Wired Description", title: 'Science Tech', user_id: 1).first_or_create

puts 'Created the First User and the First Feed'

if File.exists?("#{Rails.root}/lib/txt/personal_feeds.txt")

	puts 'Populate Personal Feeds table ...' 

	Feed.delete_all
	Feedlist.delete_all
  open("#{Rails.root}/lib/txt/personal_feeds.txt") do |feed|
		feed.read.each_line do |data|
	  		rssurl, title, user_id, tags_list = data.chomp.split("|")
        begin
	    	  Feed.create!(:rssurl => rssurl, :user_id => user_id, :title => title, :tag_list => tags_list)
	  	  rescue Exception => exc
          puts "#{rssurl} #{exc.message}"
        end
      end
	end

end

puts 'Populate Categories table ...'

Category.delete_all
open("#{Rails.root}/lib/txt/categories.txt") do |category|
	category.read.each_line do |data|
  		name, image, language = data.chomp.split("|")
    	image_src = "#{Rails.root}/app/assets/images/categories/#{image}.jpg"
    	src_file = File.new(image_src)
    	category = Category.create!(:name => name, :category_logo => src_file, :language => language)
  		puts "Created #{category.name} Category"
  	end
end

puts 'Populate Recommended Feeds table ...'

RecommendedFeed.delete_all
open("#{Rails.root}/lib/txt/recommended_feeds.txt") do |recommended_feed|
	recommended_feed.read.each_line do |data|
  		title, image, rssurl, category_name, tag_list, language = data.chomp.split("|")
  		puts "Category found: #{category_name}"
      category = Category.find_by(name: category_name, language: language)
  		image_src = "#{Rails.root}/app/assets/images/recommended_feeds/#{image}.jpg"
  		src_file = File.new(image_src)
  		recommended_feed = RecommendedFeed.create!(:title => title, :rssurl => rssurl, :logo => src_file, category_ids: category.id)
  		puts "Created #{recommended_feed.title} Recommended Feed"    	
  	end
end