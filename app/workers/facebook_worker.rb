class FacebookWorker

  include Sidekiq::Worker
  
  def perform(user, url)

  	user = User.find(user)
  	
  	user.facebook.put_connections("me", "pamparito:guardar", noticia: url)
    
  end

end