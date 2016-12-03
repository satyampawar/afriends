module LastSeenUser
  extend ActiveSupport::Concern
  included do
  end

  def set_last_seen
  	if params[:action] != "who_is_online"
  		current_user.update(last_seen:  Time.now) if authenticate_user!
    end
  end
end

