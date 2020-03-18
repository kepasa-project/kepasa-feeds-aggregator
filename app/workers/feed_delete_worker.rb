class FeedDeleteWorker
  
  include Sidekiq::Worker
  sidekiq_options :retry => false #when fail don't repeat

  def perform(feed_id)
  	@feed = Feed.find(feed_id)
    @feed.destroy
  end

end