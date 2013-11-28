# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Person do
  before do 
    @user = User.new(email: "example@user.com", password: "foobar", password_confirmation: "foobar")
    @user.build_person.build_profile( first_name: "Pat", last_name: "White" )
    @person = @user.person
  end

  subject { @person }

  it { should respond_to(:user) }
  it { should respond_to(:profile) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:full_name) }
  it { should respond_to(:conversations) }
  it { should respond_to(:posts) }

  describe "object should have same full name as profile" do
  	its(:full_name) { should == "Pat White"}
  end

end
