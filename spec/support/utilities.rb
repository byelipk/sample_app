# This file is a place to store functions used for Rspec testing

def full_title(page_name)
	base_title = "Ruby on Rails Tutorial Sample App"
	if page_name.empty?
		base_title
	else
		"#{base_title} | #{page_name}"
	end
end