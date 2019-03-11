# frozen_string_literal: true

class Bookmark < ActiveRecord::Base
  paginates_per 5

  acts_as_taggable_on :tags

  belongs_to :user

  validates :url, presence: true
  validates :title, presence: true
  validates :tag_list, presence: true
end
