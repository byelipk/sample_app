require 'spec_helper'

describe "Authentication process when we" do

    subject { page }

    context "sign in to the application" do

        before { visit signin_path }

        describe "with invalid information" do

          before { click_button "Sign in" }

          it { should have_selector('title', text: 'Sign in') }
          it { should have_selector('div.notice', text: 'Whoops') }
        end

        describe "after visiting another page" do
            before { click_link "kshizzy" }
            
            it { should_not have_selector('title', text: 'Sign in') }
            it { should_not have_selector('div.alert.alert-error') }
        end      

        describe "with valid information" do

            let(:user) { FactoryGirl.create(:user) }
            
            context "as an activated user" do
                
                before do
                    active_user = set_user_to_active(user)
                    fill_in "email",    with: active_user.email.upcase
                    fill_in "password", with: active_user.password
                    click_button "Sign in"
                end   
                
                it { should_not have_link("Sign in", href: signin_path) }
                
                it { should have_selector('title', text: user.person.full_name) } 
                it { should have_link('Sign out', href: signout_path) }
                
                describe "followed by signout" do
                    before { click_link "Sign out" }
                    it { should have_link('Sign in') }
                end            
            end

            context "as an unactivated user" do

                before do
                    fill_in "email",    with: user.email.upcase
                    fill_in "password", with: user.password
                    click_button "Sign in"
                end

                it { should_not have_selector('title', text: user.person.full_name) } 
                it { should_not have_link('Sign out', href: signout_path) }

                it { should have_selector('title', text: "Account Activation") }
                it { should have_selector('h3', text: "Activate your account") }
            end
        end
    end
end