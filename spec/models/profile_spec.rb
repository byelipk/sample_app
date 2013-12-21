# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  first_name :string(127)
#  last_name  :string(127)
#  birthday   :date
#  gender     :string(255)
#  searchable :boolean          default(TRUE)
#  person_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Profile do
  let(:user) { FactoryGirl.create(:user) }
  let(:profile) { user.profile }

  it "should have a valid factory" do
    FactoryGirl.create(:profile).should be_valid
  end

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:full_name) }
  it { should respond_to(:person) }

  it "humanizes first and last name strings during save" do
    crazy_name = profile
    crazy_name.first_name = "moREECE"
    crazy_name.last_name  = "VAUGHN"
    crazy_name.save
   
    crazy_name.full_name.should eq("Moreece Vaughn")
  end

  context "#first_name" do
  	it "can be set" do
  	   profile.first_name = "Darth" 
  	   profile.first_name.should eq("Darth") 
  	end  
    it "will raise error when set with a nil or empty value" do
      [nil, "", " "].each do |fail| 
        profile.first_name = fail
        profile.last_name  = "Pass"
        profile.should_not be_valid
      end
    end  
  end

  context "#last_name" do
  	it "can be set" do
  	  profile.last_name = "Vader" 
  	  profile.last_name.should eq("Vader") 
  	end   
    it "will raise error when set with a nil or empty value" do
      [nil, "", " "].each do |fail|
        profile.first_name = "Pass" 
        profile.last_name = fail
        profile.should_not be_valid
      end
    end   
  end

  context "#full_name" do
    it "is not a setter method" do
      expect(:full_name=).to raise_error(NoMethodError)
    end
    it "concatinates #first_name and #last_name" do
      profile.full_name.should eq "Marko Polo"
    end 
  end

  context "#person" do
    it "returns the same object as user#person" do
  	  profile.person.should eq user.person
    end 
  end
end