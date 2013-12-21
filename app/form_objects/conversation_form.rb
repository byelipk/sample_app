class ConversationForm < BaseForm

	def self.model_name
		ActiveModel::Name.new(self, nil, "Conversation")
	end

	# -- VALIDATIONS
	validates :title, presence: true
	validates :content, presence: true

	# -- DELEGATIONS
	delegate :title, to: :conversation
	delegate :content, to: :post	

	def initialize(person)
		@person = person
	end

	def conversation(params={})
		@conversation ||= @person.start_conversation(params)
	end

	def post
		@post ||= conversation.setup_first_post
	end

	def submit(convo_params, post_params)
		conversation.attributes = convo_params
		post.attributes   		= post_params
		if valid?
			conversation.save!
			post.save!
			# Set the new_post_id to the current post then save
			conversation.set_first_post(post.id) 
			true
		else
			false
		end
	end
end