class VideoChat < ActiveRecord::Base
before_save :generate_token

def generate_token
	debugger
	self.token_base = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless VideoChat.exists?(token_base: random_token)
  end
end
end