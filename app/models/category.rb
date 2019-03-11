# frozen_string_literal: true

class Category < ActiveRecord::Base
  mount_uploader :category_logo, CategoryLogoUploader

  enum language: { en: 0, es: 1 }

  has_and_belongs_to_many :recommended_feeds
end
