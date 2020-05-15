class AdminBaseController < ApplicationController
  
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || current_user.locale
  end

  def self.default_url_options(options={})
    options.merge({ :locale => I18n.locale })
  end

end