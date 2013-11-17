require 'spec_helper'

describe "StaticPages" do

	subject { page }

	context "Home page" do

		before { visit root_path }

		it { should have_selector('h1', text: "Welcome") }
		it { should have_selector('title', text: full_title('')) }
		it { should_not have_selector('title', text: full_title('Home')) }
	end

	context "Help page" do

		before { visit help_path }

		it { should have_selector('h1', text: "Help") }
		it { should have_selector('title', text: full_title('Help')) }	
	end

	context "About page" do

		before { visit about_path  }

		it { should have_selector('h1', text: "About Us") }
		it { should have_selector('title', text: full_title('About')) } 	
	end

	context "Contact page" do

		before { visit contact_path }

		it { should have_selector('h1', text: "Contact Us") }
		it { should have_selector('title', text: full_title('Contact')) }
	end

	it "should have the right links on the layout" do
	    visit root_path
	    click_link "About"
	    page.should have_selector 'title', text: full_title('About Us')
	    click_link "Help"
	    page.should have_selector 'title', text: full_title('Help')
	    click_link "Contact"
	    page.should have_selector 'title', text: full_title('Contact')
	    # click_link "Privacy"
	    # page.should have_selector 'title', text: full_title('Privacy')
	    # click_link "Blog"
	    # page.should have_selector 'title', text: full_title('Blog')
	    # click_link "Jobs"
	    # page.should have_selector 'title', text: full_title('Jobs')
	    # click_link "Dev"
	    # page.should have_selector 'title', text: full_title('Development') 
	    # click_link "Terms"
	    # page.should have_selector 'title', text: full_title('Terms & Conditions')
	    # click_link "News"
	    # page.should have_selector 'title', text: full_title('News')               
	end	
end
