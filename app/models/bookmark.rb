class Bookmark < ActiveRecord::Base
  
  paginates_per 5

  #attr_accessible :tag_list, :title, :url, :user_id
  
  acts_as_taggable_on :tags
  
  belongs_to :user

  validates :url, presence: :true
  validates :title, presence: :true
  validates :tag_list, presence: :true
  
  #default_scope :order => 'bookmarks.created_at DESC'
  
end
