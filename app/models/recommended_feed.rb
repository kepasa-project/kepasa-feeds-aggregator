class RecommendedFeed < ApplicationRecord

	#belongs_to :category
	has_and_belongs_to_many :categories

end
