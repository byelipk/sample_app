require 'spec_helper'
require 'ruby-debug'

describe "UserPages" do

	subject { page }

    describe "signup page" do
	    before { visit signup_path }

	    it { should have_selector('span',    text: 'Sign up') }
	    it { should have_selector('section.signin-signup-wrapper') }
		it { should have_selector('title', text: full_title('Create your Account') ) }
	end
	
	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }

		before { visit user_path(user) }

		it { should have_selector('title',  text: user.person.full_name) }
	end

	describe "sign-up process" do
	    
	    before { visit signup_path }
	    
	    let(:submit) { 'Create my account' }

	    context "with invalid information" do
	      
	      it "should not create a user" do
	        expect { click_button submit }.not_to change(User, :count)
	      end

	      describe "error messages after submission" do
	        before { click_button submit }

	        # This is the implementation for early development and it will change
	        it { should have_selector('div.fakebottom-row') }
	        it { should have_selector('div.alert.alert-error', text: 'Access') }
	      end
	    end	

	    context "with valid information" do
			
			before do
				fill_in "user_profile_attributes_first_name",     with: "Marko"
				fill_in "user_profile_attributes_last_name",      with: "Polo"
				fill_in "user_email",         					  with: "byelipk@hotmail.com"
				fill_in "user_password",       					  with: "foobar"
				fill_in "user_password_confirmation",			  with: "foobar"			
			end	        

	    	it "should create a new user" do
	    		expect { click_button submit }.to change(User, :count).by(1) 		
	    	end

	    	describe "after saving the user" do
	    		before { click_button submit }
	    		it { should have_selector('title', text: "Account Activation") }
	    	end
	    end	

	    # As we move closer to a public beta this will need to be changed
	    context "without a white-listed email" do
			
			before do
				fill_in "user_profile_attributes_first_name",     with: "Marko"
				fill_in "user_profile_attributes_last_name",      with: "Polo"
				fill_in "user_email",         					  with: "not@allowed.com"
				fill_in "user_password",       					  with: "foobar"
				fill_in "user_password_confirmation",			  with: "foobar"	
			end	        

	    	it "should not create a new user" do
	    		expect { click_button submit }.to change(User, :count).by(0)    		
	    	end


	    	describe "should display message that access is closed" do
	    		before { click_button submit }
	    		
	    		it { should have_selector('div.alert.alert-error', text: 'Access') }
	    	end
	    end
	end	
end

