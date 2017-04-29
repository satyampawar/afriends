class SettingsController < ApplicationController
  def index
  	@friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
  	@friendlist=current_user.friendlist if user_signed_in?
    @notifications = current_user.notifications if user_signed_in?

    s = @friendlist.map(&:friend_id)
    
    f_f_id = User.where(id: s).collect{|k| k.friendlist}.flatten.map(&:friend_id).uniq - (current_user.friendlist.map(&:friend_id) + current_user.id.to_s[0..1000].split(','))
    @find_friends = User.where(id: f_f_id)
  end

  def block_person
     
  end
end