# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string(255)
#  password_digest            :string(255)
#  remember_token             :string(255)
#  admin                      :boolean          default(FALSE)
#  active                     :boolean          default(FALSE)
#  verified_email             :boolean          default(FALSE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  password_reset_token       :string(255)
#  password_reset_sent_at     :datetime
#  confirmation_token         :string(255)
#  confirmation_token_sent_at :datetime
#

class User < ActiveRecord::Base

  # We upgraded to using strong-parameters 
  # - a core feature of Rails 4 - so we don't need to use attr_accessible
  
  has_secure_password

  # -- ASSOCIATIONS
  has_one :person, :dependent => :destroy
  has_one :profile, :through => :person                            

  # -- VALIDATIONS
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  # -- CALLBACKS
  before_save { email.downcase! }
  before_save :create_remember_token
  after_validation { self.errors.messages.delete(:password_digest) }
  after_create :send_confirmation_request 
  
  # -- DELEGATIONS
  delegate :activate_account, :account_activated?, :to => :account_activator

  # -- INSTANCE METHODS
  
  def account_activator
    UserActivation.new(self)
  end

  def build_associations( profile_params={} )
    self.build_person.build_profile( profile_params )
  end

  def send_password_reset
    generate_token( :password_reset_token )
    self.password_reset_sent_at = Time.zone.now
    save( validate: false )
    UserMailer.password_reset(self).deliver
  end

  def send_confirmation_request
    generate_token( :confirmation_token )
    self.confirmation_token_sent_at = Time.zone.now
    save( validate: false )
    UserMailer.account_confirmation(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  # -- PRIVATE METHODS
  
  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end