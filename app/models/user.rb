# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  active          :boolean          default(FALSE)
#  verified_email  :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  
  has_secure_password

  has_one  :person, :foreign_key => :owner_id
  # -- Simple, many-to-one association set-up & instance methods
  has_many :microposts, dependent: :destroy
  has_many :email_verifications, dependent: :destroy
  # -- Complex, many-to-many association set-up & instance methods
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower                               

  # -- Validations
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  # -- Callbacks
  before_save { email.downcase! }
  before_save :create_remember_token
  after_validation { self.errors.messages.delete(:password_digest) }
  after_create :send_confirmation_email  
  
  # Delegations
  delegate :activate, :activated?, :to => :user_activator

  # -- Instance methods

  def feed
    Micropost.from_users_followed_by(self) 
  end

  def follow!(other_user)
    # follower_id is self.id
    self.relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end

  def fullname
    "#{self.first_name.to_s} #{self.last_name.to_s}".titleize
  end

  def user_activator
    UserActivation.new(self)
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    def send_confirmation_email
      self.email_verifications.create!
    end
end
