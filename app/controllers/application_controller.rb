class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  APP_DOMAIN = 'www.kepasa.co'

  skip_before_action :verify_authenticity_token

  before_action :ensure_domain
  before_action :configure_permitted_parameters, if: :devise_controller?

  def ensure_domain
      #unless request.env['HTTP_HOST'] == APP_DOMAIN || Rails.env.development?
      #  redirect_to "http://#{APP_DOMAIN}", :status => 301
      #end
  end

  # begin handle Error snippet if no Record is Found!
  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end
  # end error snippet
  
  private

  def configure_permitted_parameters
      attributes = [:username, :email, :password, :password_confirmation]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
