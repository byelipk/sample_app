# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#  active          :boolean          default(FALSE)
#  verified_email  :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  # -- Associations

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

  # -- Attempt just before saving user into the DB
  before_save { email.downcase! }
  before_save :create_remember_token

  # -- Validations
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  after_validation { self.errors.messages.delete(:password_digest) }

  # -- Instance methods

  def feed
    Micropost.from_users_followed_by(self) 
  end

  def follow!(other_user)
    # follower_id is self.id
    self.relationships.create!(followed_id: other_user.id)
  end

  # ARGS: User object
  # RETURN TYPE: Relationship object
  # RETURN VALUE: It returns an instance of the Relationship class
  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end
  
  # -- Private methods

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end


