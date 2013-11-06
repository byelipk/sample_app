require 'spec_helper'

describe "StaticPages" do

	subject { page }

	context "Home page" do
		pending
		before { visit root_path }

		it { should have_selector('h1', text: "Welcome") }
		it { should have_selector('title', text: full_title('')) }
		it { should_not have_selector('title', text: full_title('Home')) }
	end

	context "Help page" do
		pending
		before { visit help_path }

		xit { should have_selector('h1', text: "Help") }
		xit { should have_selector('title', text: full_title('Help')) }	
	end

	context "About page" do
		pending
		before { visit about_path  }

		xit { should have_selector('h1', text: "About Us") }
		xit { should have_selector('title', text: full_title('About')) } 	
	end

	context "Contact page" do
		pending
		before { visit contact_path }

		xit { should have_selector('h1', text: "Contact Us") }
		xit { should have_selector('title', text: full_title('Contact')) }
	end

  it "should have the right links on the layout" do
  	pending
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "sample app"
    page.should have_selector 'title', text: full_title('')
  end	
end
