class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  require 'nokogiri'
  require 'open-uri'
  
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    #feedlist = request.env["omniauth.params"]
    
    rssurl = cookies[:omniauth]
    
    unless rssurl.blank?

        FacebookWorker.perform_async(@user.id, rssurl)

        if @user.persisted?

            sessione = cookies[:omniauth]

            v = sessione.split('/')
            v = v.last

            rssurl = Feedlist.find(v.to_i).rssurl.to_s
            doc = Nokogiri::XML(open(rssurl, 'User-Agent' => 'firefox')) 
            title = doc.at_xpath('/rss/channel/title').inner_text
         
            sign_in @user, :event => :authentication #this will throw if @user is not activated
            feed = Feed.create(:rssurl => Feedlist.find(v).rssurl, :user_id => @user.id, :title => title)
            Feedlist.usuario(@user.id, rssurl)
            Feedlist.update_from_feed(rssurl)
            set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
            redirect_to sessione
            cookies.delete(:omniauth)

        else

            session["devise.facebook_data"] = request.env["omniauth.auth"]
            redirect_to new_user_registration_url

        end

    else
        
        if @user.persisted?
        
        sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated 
        set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
              
        else

        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url

        end

    end

  end


  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  

end