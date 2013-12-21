class PostPresenter
	def initialize(post, template)
		@post 			= post
		@template 		= template
	end

	delegate :conversation, to: :@post

	def actions
		if conversation.first_post_id == @post.id
			render 'conversations/partials/actions'
		end	
	end

	# Defining method_missing here allows us to simply call
	# render instead of @template.render
	def method_missing(method_name, *args, &block)
		@template.send(method_name, *args, &block)
	end	
end