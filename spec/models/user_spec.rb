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

require 'spec_helper'

describe User do

  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:person) }
  it { should respond_to(:profile) }

  it { should be_valid }

  describe "validation when email is not present" do
  	before { user.email = "" }	
  	it { should_not be_valid }
  end

  describe "validation when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
        	user.email = invalid_address
        	user.should_not be_valid 
        end
  	end
  end

  describe "validation when email format is valid" do
  	it "should be valid" do
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
  			user.email = valid_address
  			user.should be_valid 
  		end
  	end
  end

  describe "validation when email is already taken" do
    let(:user_with_same_email) { user.dup }
    it "a new user should not be saved to the database" do
      user_with_same_email.email = user.email.upcase
      user_with_same_email.build_associations({ first_name: "Pat", last_name: "White" })
      user_with_same_email.should have(1).error_on(:email) 
    end
  end

  describe "validation of email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }
    it "should be saved as all lower-case" do
      user.email = mixed_case_email
      user.save
      user.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "validation when password is not present" do
    before { user.password = user.password_confirmation = " " }
    it { should have(1).error_on(:password_confirmation) }
  end

  describe "validation when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { should have(1).error_on(:password) }
  end

  describe "validation when password confirmation is nil" do
    before { user.password_confirmation = nil }
    it { should have(1).error_on(:password_confirmation) }
  end

  describe "validation when password is too short" do
    before { user.password = user.password_confirmation = "a" * 5 }
    it { should_not be_valid }
  end
  
  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by_email(user.email) }

    context "with valid password" do
      it { should == found_user.authenticate(user.password) }
    end

    context "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "confirmation token" do
    before { user.save }
    its(:confirmation_token) { should_not be_blank }  
  end

  describe "default states" do
    before { user.save }
    its(:admin) { should == false}
    its(:active) { should == false}
    its(:verified_email) { should == false}
  end
end
