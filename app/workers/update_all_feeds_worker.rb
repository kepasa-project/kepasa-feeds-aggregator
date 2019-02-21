class UpdateAllFeedsWorker

	include Sidekiq::Worker
  	sidekiq_options :retry => false #when fail don't repeat

  
	  def perform(user_id)

	  	Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
	    Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
	    
	    @user = User.find(user_id)
	    
	    @user.feeds.find_each do |feed|

	        #@feed_update = Feed.find(feed_id)
	        @feed_update = feed
	        rssurl = @feed_update.rssurl

	        @feed = Feed.where(:user_id => user_id, :rssurl => rssurl.to_s).last

#snippet added after 

	        xml = HTTParty.get(@feed.rssurl).body
			feed = Feedjira::Feed.parse xml	        

#end snippet

	        #feed = Feedjira::Feed.fetch_and_parse(@feed.rssurl)
	        
	        unless feed.is_a?(Fixnum) #HTTP fetch results is not an error (i.e. not a 200 or 3XX)

	          feed.entries.each do |entry|  

	          #object = LinkThumbnailer.generate(@feed.rssurl)
	          #page = MetaInspector.new(@feed.rssurl)

	          entry.published.nil? ? @datafeedlist = Time.now() : @datafeedlist = entry.published
	          #entry.media_thumbnail_url.nil? ? @imageurl = page.images.best : @imageurl = entry.media_thumbnail_url

	              unless Feedlist.where(:feed_id => @feed.id).exists? :guid => entry.id

	                    Feedlist.create!(
	                      :rssurl       => @feed.rssurl,
	                      :name         => entry.title.to_s.force_encoding("UTF-8"),
	                      :summary      => entry.summary.to_s.force_encoding("UTF-8"),
	                      :url          => entry.url,    
	                      :published_at => @datafeedlist,
	                      :guid         => entry.id,
	                      :content 		=> entry.content,
	                      :image        => entry.media_thumbnail_url,
	                      :feed_id      => @feed.id,
	                      :user_id      => @user.id
	                    )
	              end
	          end 

	        end #End IF HTTP fetch status

		end #end feeds loops

	    end # end perfom method

end