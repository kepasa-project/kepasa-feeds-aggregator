class ApplicationController < ActionController::Base

  before_action :set_locale
  
  APP_DOMAIN = ENV['DOMAIN']

  skip_before_action :verify_authenticity_token

  #before_action :ensure_domain
  before_action :configure_permitted_parameters, if: :devise_controller?

  def ensure_domain
      unless request.env['HTTP_HOST'] == APP_DOMAIN || Rails.env.development?
        redirect_to "http://#{APP_DOMAIN}", :status => 301
      end
  end
  
  def retrieve_image(summary)
    
  @doc = Nokogiri::HTML(summary)

  @doc.css('img').each do |node|    
    node.each do |attr,attr_val|
      if attr == "src"
        @attr_val = attr_val
      else
        @attr_val = nil
      end
    end
  end

  return @attr_val

  end
  
  private

  def set_locale
    if user_signed_in?
      I18n.locale = current_user.locale
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
    Rails.application.routes.default_url_options[:locale]= I18n.locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  def configure_permitted_parameters
      attributes = [:username, :email, :password, :password_confirmation, :locale]
      devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
      devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end