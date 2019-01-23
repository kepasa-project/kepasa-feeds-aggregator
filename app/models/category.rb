class Category < ApplicationRecord

	enum language: { en: 0, es: 1 }

	#has_many :recommended_feeds
	has_and_belongs_to_many :recommended_feeds

end
