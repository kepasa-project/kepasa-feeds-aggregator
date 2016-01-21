require_relative '../../app/workers/noticias_elpais_worker'

namespace :update_elpais do
 
  task :noticias_elpais => :environment do
 	
 		#noticias = Feedlist.where(:rssurl => "http://ep00.epimg.net/rss/tags/noticias_mas_vistas.xml")
	    #users = User.all
	    
	    #users.each do |user|
=begin
	    User.find_each do |user|
	    	#feeds = user.feedd    	
	    	#feeds.each do |feed|
			#@user = User.find(id).includes(:posts => :comments)
			#@user = User.includes(:feeds).find(user.id)

			Feed.where(:user_id => user.id).find_each do |feed|

	      	NoticiasElpaisWorker.perform_async(feed.id.to_i)

	      	sleep 5

	      	end
	    end
=end

=begin
		users = User.includes(:feeds)
			
			users.each do |user|

	      		NoticiasElpaisWorker.perform_async(user.feeds.id.to_i)

	      	sleep 5
		
		end
=end

	User.find_each do |user|

		Feed.where(:user_id => user.id).find_each(:batch_size => 200) do |feed|

	      	NoticiasElpaisWorker.perform_async(feed.id.to_i)

	      	sleep 5

	      	end
	    end

  end
end