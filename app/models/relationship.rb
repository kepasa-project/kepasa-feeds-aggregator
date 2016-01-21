class Relationship < ActiveRecord::Base
  attr_accessible :newspaper_id, :user_id, :page_id, :feed_id
  
  belongs_to :user
  belongs_to :feed
  
end
