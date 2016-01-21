class Page < ActiveRecord::Base

  attr_accessible :url, :user_id, :title
  
  validates :title, :presence => { :message => "El Nombre de la Seccion no puede ser vacio" }
  
  validates_length_of :title, :minimum => 5, :maximum => 15, :allow_blank => true

  belongs_to :user
  
  has_many :friendships
  has_many :newspapers, through: :friendships

end
