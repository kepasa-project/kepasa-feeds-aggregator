# frozen_string_literal: true

class Category < ActiveRecord::Base
  
  mount_uploader :category_logo, CategoryLogoUploader

  enum language: { English: 0, Español: 1 , Italiano: 2}

  has_and_belongs_to_many :recommended_feeds

  def self.current_language

  	language = Hash.new
	language = { en: "English", es: "Español", it: "Italiano"}
	@current_language = language[I18n.locale]

	return @current_language
  end

end
