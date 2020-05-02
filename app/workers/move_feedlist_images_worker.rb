class MoveFeedlistImagesWorker
  
  include Sidekiq::Worker
  sidekiq_options :queue => :default
  sidekiq_options :retry => false #when fail don't repeat

  def perform(feedlist_id)
  	@feedlist = Feedlist.find(feedlist_id)
    a = Rails.root.to_s.split("/")
    a.pop
    #temporary email
    b = a.join("/") + "/20200327071103/public/uploads/feedlist/article_picture/@feedlist.id"
    FileUtils.mv("#{b}", "home/kepasa/shared/public/uploads/feedlist/article_picture")
  end

end