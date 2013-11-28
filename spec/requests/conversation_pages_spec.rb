require 'spec_helper'
require 'ruby-debug'

describe "UserPages" do

	subject { page }
	
	before do 
		visit signin_path 
		let(:user) { FactoryGirl.create(:user) }
		let(:active_user) { set_user_to_active(user) }                 
        fill_in "email",    with: active_user.email.upcase
        fill_in "password", with: active_user.password
        click_button "Sign in"
        visit new_conversation_path
    end


end