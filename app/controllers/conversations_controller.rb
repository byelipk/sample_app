class ConversationsController < ApplicationController

	before_filter :signed_in_user, only: [:new, :create]
	before_filter :current_person, only: [:new, :create]

	def index
		@conversations = Conversation.all
	end

	def new
		@conversation = ConversationForm.new(current_person)
	end

	def create
		@c = ConversationForm.new(current_person)
		if @c.submit(convo_params, post_params)
			redirect_to conversation_path(@c.conversation)
		else
			render 'new'
		end
	end

	def show
		begin
			@conversation = Conversation.find(params[:id])
		rescue
			redirect_to root_url
		end
	end

	private

	def convo_params
		params.require(:conversation).permit(:title)
	end

	def post_params
		params.require(:conversation).permit(:content)
	end
end