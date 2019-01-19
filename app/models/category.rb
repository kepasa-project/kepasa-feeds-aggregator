class Category < ApplicationRecord

	#has_many :recommended_feeds
	has_and_belongs_to_many :recommended_feeds

end
