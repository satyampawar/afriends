class Message < ActiveRecord::Base
	 belongs_to :conversation
  belongs_to :user

  check

  validates_presence_of :body, :conversation_id, :user_id
end
