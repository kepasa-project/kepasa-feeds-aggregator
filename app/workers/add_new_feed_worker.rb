class AddNewFeedWorker

	include Sidekiq::Worker
  	sidekiq_options :retry => false #when fail don't repeat


  	def perform(feed_id)
                 
	  	@feed = Feed.find(feed_id)
	  	@user = @feed.user

	  	Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
	    Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
	            
	    xml = HTTParty.get(@feed.rssurl).body
	    feed = Feedjira::Feed.parse xml

	    #@user = current_user
	    #@feed = Feed.find(params[:id])
	    #feed = Feedjira::Feed.fetch_and_parse(@feed.rssurl)
	                      
	    feed.entries.each do |entry|  

	        entry.published.nil? ? @datafeedlist == Time.now() : @datafeedlist = entry.published

	        unless Feedlist.where(:feed_id => @feed.id).exists? :guid => entry.id

	              Feedlist.create!(
	                :rssurl       => @feed.rssurl,
	                :name         => entry.title,
	                :summary      => entry.summary,
	                :url          => entry.url,    
	                :published_at => @datafeedlist,
	                :guid         => entry.id,
	                :image        => entry.media_thumbnail_url,
	                :content      => entry.content,
	                :feed_id      => @feed.id,
	                :user_id      => @user.id
	              )
	        end
	    end

	end # end perform method

end