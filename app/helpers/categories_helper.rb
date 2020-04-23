module CategoriesHelper
   
   def check_feed(rf)
    
    @rf = rf
    feeds = current_user.feeds
    feed = feeds.find_by_rssurl(@rf.rssurl)
    feed.nil? ? a = false : a = true
    
    return a

   end

end
