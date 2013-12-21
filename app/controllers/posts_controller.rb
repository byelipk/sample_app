class PostsController < ApplicationController
	
	before_filter :post_params, only: [:new, :create]
	before_filter :convo_params, only: [:new, :create]
	before_filter :new_post_params, only: [:new, :create]
	
	respond_to :html, :js

	def index
		raise
	end

	def new
		@post = current_person.posts.build(new_post_params)
		respond_with @post
	end

	def create
		@post = current_person.posts.build(new_post_params)
		
		begin
		 	@post.save!
			respond_with @post
		rescue ActiveRecord::RecordInvalid => e
			render text: e.message + " ... " + @post.to_json
		end

	end

	private

	def post_params
		params.require(:post).permit(:prev_post_id, :content)
	end

	def convo_params
		params.permit(:conversation_id)
	end

	def new_post_params
		convo_params.merge(post_params)
	end
end