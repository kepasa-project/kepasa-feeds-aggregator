class User < ActiveRecord::Base

  #attr_accessible :login
  
  paginates_per 5

  #default_scope :order => 'users.created_at DESC'

  # added these 2 lines to add the Gravatar in the app
  include Gravtastic
  gravtastic :secure => true,
              :filetype => :gif,
              :size => 30

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # adding :authentication_keys => [:login] to login using username or email
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook], :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model. Add also :username after add a column for the Devise Model
  # attr_accessible :email, :username, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates :email, :presence => true, :email => true

  # DM system methods
  acts_as_messageable

  has_many :bookmarks, :dependent => :destroy
  
  has_many :feeds
  has_many :feedlists

  has_many :pages, :dependent => :destroy
  
  has_many :relationships
  has_many :newspapers, through: :relationships

  # begin snippet for relationship among users
  has_many :following_relationships, :foreign_key => "follower_id",
                                      :dependent => :destroy
  
  has_many :following, :through => :following_relationships, :source => :followed
  
  has_many :reverse_following_relationships, :foreign_key => "followed_id",
                                             :class_name => "FollowingRelationship",
                                             :dependent => :destroy
  
  has_many :followers, :through => :reverse_following_relationships, :source => :follower
  # end snippet for relationship among users

  # SEO User url profile
  extend FriendlyId
  friendly_id :username
  
  #after_create :add_user_to_mailchimp
  #before_destroy :remove_user_from_mailchimp
 
  # [A.] snippet to login using username or email according the Devise best practice
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
  # [A.] end snippet 

  # [B.] snippet to login using username or email
  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions.to_h).first
      end
  end
  # [B.] end snippet

  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      #for me the follow line save without confirmation
      user.skip_confirmation!
    end
    
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
  end
  
  def following?(followed)
        following_relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
        
        @relationship = following_relationships.create!(:followed_id => followed.id)
        
  end
  
  def unfollow!(followed)
        
        @relationship = following_relationships.find_by_followed_id(followed)
        @relationship.destroy
        
  end

  def feed
        # la seguente riga evita il problema di SQL Iniection
        #Question.where("user_id = ?", id)
        Feed.from_users_followed_by(self)
        
  end
  
  def mailboxer_email(object)
    email
  end
  
  private

      def add_user_to_mailchimp
        #return if email.include?(ENV['ADMIN_EMAIL'])
        mailchimp = Gibbon::API.new
        result = mailchimp.lists.subscribe({
          :id => ENV['MAILCHIMP_LIST_ID'],
          :merge_vars => {:FNAME => self.username},
          :email => {:email => self.email},
          :double_optin => false,
          :update_existing => true,
          :send_welcome => true
          })
        Rails.logger.info("Subscribed #{self.email} to MailChimp") if result
      end

      def remove_user_from_mailchimp
        mailchimp = Gibbon::API.new
        result = mailchimp.lists.unsubscribe({
          :id => ENV['MAILCHIMP_LIST_ID'],
          :email => {:email => self.email},
          :delete_member => true,
          :send_goodbye => false,
          :send_notify => true
          })
        Rails.logger.info("Unsubscribed #{self.email} from MailChimp") if result
      end

end