class Newspaper < ActiveRecord::Base
  attr_accessible :rssurl, :title, :position, :page_id
  
  validates :title, :presence => true
  validates :rssurl, :presence => true
  
  has_many :news, :class_name => 'New'
  
  has_many :relationships
  has_many :users, through: :relationships
  
  has_many :friendships
  has_many :pages, through: :friendships
  
  
  
end
