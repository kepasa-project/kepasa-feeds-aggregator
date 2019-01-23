class UpdatefeedskWorker

  include Sidekiq::Worker
  
  def perform(user_id)

  	Feedjira::Feed.add_common_feed_entry_element("media:thumbnail", :value => :url, :as => :media_thumbnail_url)
    Feedjira::Feed.add_common_feed_entry_element("enclosure", :value => :url, :as => :media_thumbnail_url)
    
    @user = User.find(user_id)
    
    @user.feeds.find_each do |feed|

        #@feed_update = Feed.find(feed_id)
        @feed_update = feed
        rssurl = @feed_update.rssurl

        @feed = Feed.where(:user_id => user, :rssurl => rssurl.to_s).last

        feed = Feedjira::Feed.fetch_and_parse(@feed.rssurl)
        
        unless feed.is_a?(Fixnum) #HTTP fetch results is not an error (i.e. not a 200 or 3XX)

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
                      :content      => entry.content,
                      :feed_id      => @feed.id,
                      :user_id      => @user.id
                    )
              end
          end 

        end #End IF HTTP fetch status

	end #end feeds loops

    end # end perfom method

end