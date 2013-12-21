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

  it "has a valid factory" do
    FactoryGirl.create(:person).should be_valid
  end

  it { should respond_to(:user) }
  it { should respond_to(:profile) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:full_name) }
  it { should respond_to(:conversations) }
  it { should respond_to(:posts) }
  it { should respond_to(:start_conversation) }

  describe "delegates method" do 	
  	let(:user) { FactoryGirl.create(:user) }
  	let(:person) { user.person }
    let(:profile) { user.profile }

	  it "#first_name to Profile" do
	    expect(person.first_name).to eq profile.first_name
	  end

  	it "#last_name to Profile" do
  	  expect(person.last_name).to eq profile.last_name
  	end

    it "#full_name to Profile" do
 	    expect(person.full_name).to eq profile.full_name
  	end
  end

  context "#start_conversation" do 	
  	it "returns an instance of Conversation" do
  	  conversation = subject.start_conversation
  	  expect(conversation).to be_an_instance_of(Conversation) 
  	end

  	it "accepts an optional parameter hash" do
  	  conversation = subject.start_conversation(title: "Foobar")
  	  expect(conversation.title).to eq "Foobar"
  	end
  end

  context "#conversations" do
  	it "returns an array" do
      expect(subject.conversations).to be_an_instance_of(Array)
  	end
    it "sorts conversations in reverse chronological order"

  end

  context "#posts" do
  	it "returns an array" do
      expect(subject.posts).to be_an_instance_of(Array)
  	end
  end
end
