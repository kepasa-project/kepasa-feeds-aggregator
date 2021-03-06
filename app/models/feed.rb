# encoding: utf-8
class Feed < ActiveRecord::Base
  
  acts_as_taggable_on :tags
  
  belongs_to :user, required: false
  has_many :feedlists, :dependent => :destroy

  #has_many :relationships
  #has_many :users, through: :relationships

  #accepts_nested_attributes_for :user, :allow_destroy => true
  
  validates :rssurl, presence: :true
  validates :rssurl, :uniqueness => {:scope => :user_id}
  validates :rssurl, url: true
  #validates :tag_list, presence: :true, :allow_blank => true

  # line for the feed on the user show page
  # scope :from_users_followed_by, lambda { |user| followed_by(user) }

  #after_save :add_favicon
  
  private

    def add_favicon

      split_feed = self.rssurl.split("/")
      link = split_feed[0] + "//" + split_feed[2]

      begin
    
      object = LinkThumbnailer.generate(link)
      self.favicon = object.favicon
      self.save!
      
        rescue LinkThumbnailer::Exceptions => e
      
      puts e

      end


    end

end