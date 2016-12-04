class SessionsController < Devise::SessionsController
	def destroy
		current_user.update_attributes(last_seen: nil)
		super
	end	
end 