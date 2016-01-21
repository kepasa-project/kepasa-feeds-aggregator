class NoticiasElpaisWorker

  include Sidekiq::Worker
  
  sidekiq_options :queue => :critical

    def perform(feed_id)

    #Feedlist.usuario(@user.id, @feed_update.rssurl)
		#Feedlist.update_from_feed(@feed_update.rssurl)    

#=begin

      Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
      Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
        
        @feed_update = Feed.find(feed_id)
        @user = @feed_update.user
        user = @user.id.to_i
        rssurl = @feed_update.rssurl

        @feed = Feed.where(:user_id => user, :rssurl => rssurl.to_s).last

        feed = Feedjira::Feed.fetch_and_parse(@feed.rssurl)
        
          feed.entries.each do |entry|  

              if entry.published.nil?

                @datafeedlist == Time.now()

               else
               
               @datafeedlist = entry.published
              
              end

              unless Feedlist.where(:feed_id => @feed.id).exists? :guid => entry.id

                    Feedlist.create!(
                      :rssurl       => @feed.rssurl,
                      :name         => entry.title,
                      :summary      => entry.summary,
                      :url          => entry.url,    
                      :published_at => @datafeedlist,
                      :guid         => entry.id,
                      :image        => entry.media_thumbnail_url,
                      :feed_id      => @feed.id
                    )
              end
          end 

#=end
    end # end perfom method

end