# This file is a place to store functions used for Rspec testing

def full_title(page_name)
	base_title = "Ruby on Rails Tutorial Sample App"
	if page_name.empty?
		base_title
	else
		"#{base_title} | #{page_name}"
	end
end

def set_user_to_active(user)
	user.active 			= true
	user.verified_email 	= true
	user.save
	user
end

def sign_in(user)
	visit signin_path                  
    fill_in "email",    with: user.email.upcase
    fill_in "password", with: user.password
    click_button "Sign in"
end
