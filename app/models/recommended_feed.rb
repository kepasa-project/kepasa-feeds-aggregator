class RecommendedFeed < ApplicationRecord

	attr_accessor :tag_list

	acts_as_taggable_on :tags

	#belongs_to :category
	has_and_belongs_to_many :categories

end
