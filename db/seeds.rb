# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create({{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create({name: 'Emanuel', city: cities.first)
  
user = User.create(username: 'Reader', email: 'reader@kepasa.mx', password: 'password', password_confirmation: 'password')

puts 'Created the First User'

feed = Feed.create(rssurl: 'https://www.wired.com/feed/category/science/latest/rss', title: 'Science Tech', tag_list: 'science', user_id: 1)

puts 'Created the First Feed'

puts 'Adding Categories'


