class Friendship < ActiveRecord::Base

  attr_accessible :newspaper_id, :page_id
  
  belongs_to :newspaper
  belongs_to :page

end
