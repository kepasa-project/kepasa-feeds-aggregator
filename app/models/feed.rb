class Feed < ActiveRecord::Base

  #require 'Feedjira'
  paginates_per 5

  attr_accessible :guid, :image, :name, :published_at, :rssurl, :summary, :url, :user_id, :title, :tag_list
  
  acts_as_taggable_on :tags
  
  belongs_to :user
  # in the follow  line dependent => :destroy help us to destroy all its feedlists
  has_many :feedlists, :dependent => :destroy

  validates :rssurl, presence: :true

  validates :rssurl, :uniqueness => {:scope => :user_id}

  # la linea seguente non so come fa riferimento al file 
  validates :rssurl, url: true

  validates :tag_list, presence: :true
  
  #has_many :relationships
  #has_many :users, through: :relationships

  #accepts_nested_attributes_for :user, :allow_destroy => true 

  # line for the feed on the user show page
  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  
  private

    # Return an SQL condition for users followed by the given user.
    # We include the user's own id as well.
    def self.followed_by(user)
      following_ids = %(SELECT followed_id FROM following_relationships
                        WHERE follower_id = :user_id)
      where("user_id IN (#{following_ids}) OR user_id = :user_id",
            { :user_id => user })
    end

end
