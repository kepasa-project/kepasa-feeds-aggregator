# frozen_string_literal: true

class Bookmark < ActiveRecord::Base
  paginates_per 5

  ###this is for rspec part
  attr_accessor :acts_as_taggable_on, :tags
  def initialize (acts_as_taggable_on) 
    @acts_as_taggable_on = acts_as_taggable_on
    
  end

  ###

  acts_as_taggable_on :tags

  belongs_to :user

  validates :url, presence: true
  validates :title, presence: true
  validates :tag_list, presence: true
end
