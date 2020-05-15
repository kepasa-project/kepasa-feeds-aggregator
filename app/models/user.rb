class User < ActiveRecord::Base
  rolify

  #default_scope :order => 'users.created_at DESC'

  # added these 2 lines to add the Gravatar in the app
  include Gravtastic
  gravtastic :secure => true,
              :filetype => :gif,
              :size => 30
  
  enum locale: [:en, :es, :it, :tl]

  # NO EMAIL IN DEV
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model. Add also :username after add a column for the Devise Model
  validates :email, :presence => true
 
  has_many :bookmarks, :dependent => :destroy 
  has_many :feeds
  has_many :feedlists

  # SEO User url profile
  extend FriendlyId
  friendly_id :username
 
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