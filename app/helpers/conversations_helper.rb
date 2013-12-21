module ConversationsHelper

	def persist_conversation(post)
		@conversation ||= post.conversation
	end

end