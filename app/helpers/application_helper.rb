module ApplicationHelper

	# ARGUMENTS   : A page title as Symbol
	# RETURN TYPE : String
	# RETURN VALUE: Dynamically returns a full-page title
	def full_title(page_title)
		base_title = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
end
