module UsersHelper
	  def conversation_interlocutor(conversation)
	  binding.pry
    conversation.recipient == current_user ? conversation.sender : conversation.recipient
  end
end
