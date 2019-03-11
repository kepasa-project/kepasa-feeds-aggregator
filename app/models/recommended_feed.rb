# frozen_string_literal: true

class RecommendedFeed < ActiveRecord::Base
  mount_uploader :logo, LogoUploader

  attr_accessor :tag_list

  acts_as_taggable_on :tags

  # belongs_to :category
  has_and_belongs_to_many :categories

  # validation
  validates :rssurl, presence: true
end
