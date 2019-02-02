class Category < ApplicationRecord

	mount_uploader :category_logo, CategoryLogoUploader

	enum language: { en: 0, es: 1 }

	#has_many :recommended_feeds
	has_and_belongs_to_many :recommended_feeds

	validates :category_logo, presence: true
	
end
