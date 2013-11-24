require 'spec_helper'

describe "Authentication process when we" do

    subject { page }

    before { visit signin_path }

    context "sign in to the application" do

        describe "with invalid information" do

            context "from /signin" do

                before { click_button "Sign in" }

                it { should have_selector('title', text: 'Sign in') }
                it { should have_selector('div.notice', text: 'Invalid') }

            end

            context "from static_pages#home" do
                before do 
                    visit root_url
                    click_button "Sign in"
                end

                it { should have_selector('title', text: 'Sign in') }
                it { should have_selector('div.notice', text: 'Invalid') } 
            end
        end

        describe "after visiting another page" do
            before { click_link "kshizzy" }
            
            it { should_not have_selector('title', text: 'Sign in') }
            it { should_not have_selector('div.alert.alert-error') }
        end      

        describe "with valid information" do

            let(:user) { FactoryGirl.create(:user) }
            
            context "as an activated user" do
                let(:active_user) { set_user_to_active(user) }
                
                describe "from /signin" do    
                    before do                  
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

                describe "from static_pages#home" do
                    before do 
                        visit root_url
                        fill_in "user_email",    with: active_user.email.upcase
                        fill_in "user_password", with: active_user.password                        
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
            end

            context "as an unactivated user" do

                before do
                    fill_in "email",    with: user.email.upcase
                    fill_in "password", with: user.password
                    click_button "Sign in"
                end

                it { should_not have_selector('title', text: user.person.full_name) } 
                it { should_not have_link('Sign out', href: signout_path) }
            end
        end
    end

    context "forget our password" do

        before  { click_link "Forgot password?" }
    
        it { should have_selector( 'title', text: "Reset Password" )  }

        describe "with a valid email" do
            before do 
                fill_in "email",  with: "byelipk@hotmail.com" 
                click_button "Reset password"
            end

            it { should have_selector( 'div.alert.alert-notice' ) }
        end

        describe "with an invalid email" do
            before do 
                fill_in "email",  with: "not@allowed.com" 
                click_button "Reset password"
            end

            it { should have_selector( 'div.alert.alert-notice' ) }
        end
    end
end