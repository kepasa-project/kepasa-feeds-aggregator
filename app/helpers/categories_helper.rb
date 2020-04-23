module CategoriesHelper
   
   def check_feed(rf)
    
    @rf = rf
    feed = Feed.find_by_rssurl(@rf.rssurl)
    feed.nil? ? a = true : a = false
    
    return a

   end

end
