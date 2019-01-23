# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create({{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create({name: 'Emanuel', city: cities.first)

=begin
User.delete_all
user = User.create(username: 'Reader', email: 'reader@kepasa.mx', password: 'password', password_confirmation: 'password')

puts 'Created the First User'

if File.exists?("#{Rails.root}/lib/personal_feeds.txt")

	puts 'Creating ... Personal Feeds' 

	Feed.delete_all
	open("#{Rails.root}/lib/personal_feeds.txt") do |feed|
		feed.read.each_line do |data|
	  		rssurl, user_id, title = data.chomp.split("|")
	    	Feed.create!(:rssurl => rssurl, :user_id => user_id, :title => title)
	  	end
	end

end
=end
#feed = Feed.create(rssurl: 'https://www.wired.com/feed/category/science/latest/rss', title: 'Science Tech', tag_list: 'science', user_id: 1)

puts 'Creating ... Categories from a file to populate'

Categories.delete_all
open("#{Rails.root}/lib/categories.txt") do |category|
	category.read.each_line do |data|
  		name, language = data.chomp.split("|")
    	Category.create!(:name => name, :language => language)
  	end
end

puts 'Creating ... Recommended Feeds from a file to populate'

RecommendedFeed.delete_all
open("#{Rails.root}/lib/recommended_feeds.txt") do |category|
	countries.read.each_line do |data|
  		name, language = data.chomp.split("|")
    	Category.create!(:name => code, :language => language)
  	end
end