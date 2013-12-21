# == Schema Information
#
# Table name: conversations
#
#  id            :integer          not null, primary key
#  title         :string(255)      not null
#  person_id     :integer          not null
#  first_post_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require '../spec_helper'

describe Conversation do 

  let(:conversation) { Conversation.new }
  
  subject { conversation }

  it { should respond_to(:title) }
  it { should respond_to(:starter) }
  it { should respond_to(:setup_first_post) }

  describe "#title" do
  	context "with valid input" do
  	  pending
  	end
  	
  	context "cannot accept nil or empty as valid input" do
  	  [nil, "", " "].each do |fail|
  	    before { conversation.title = fail }
  	    it { should_not be_valid }
  	  end
  	end

  	context "cannot be greater than 140 characters" do
  	  before { conversation.title = "You shall not pass" * 8 }
  	  it { should_not be_valid }
  	end 	
  end

end
