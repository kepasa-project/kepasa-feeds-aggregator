class ApplicationController < ActionController::Base


  protect_from_forgery  :except => :create 

#=begin

  APP_DOMAIN = 'www.kepasa.co'
  before_filter :ensure_domain

  def ensure_domain
      unless request.env['HTTP_HOST'] == APP_DOMAIN || Rails.env.development?
        redirect_to "http://#{APP_DOMAIN}", :status => 301
      end
  end
  
#=end

# begin handle Error snippet if no Record is Found!
rescue_from ActiveRecord::RecordNotFound do
  flash[:warning] = 'Resource not found.'
  redirect_back_or root_path
end

def redirect_back_or(path)
  redirect_to request.referer || path
end
# end error snippet
  
end
