class NotificationsController < ApplicationController
	def index
		@notifications = current_user.notifications
	end

	def count_notifications
		@notifications = current_user.notifications
		@count = @notifications.count
		respond_to do |format|
			format.js
		end
	end
	def birthday_notification
		@users = User.where("extract(day from created_at) = #{Time.zone.now.to_date.strftime("%d")}").where("extract(month from created_at) = #{Time.zone.now.to_date.strftime("%m")}")
	  @users.each do |u|
	  @friend_ids =	u.friendlist.map(&:friend_id)
	  	@friends_ids.each do |f|
	  		notification = 	Notification.new(user_id: f.to_i,notifier_id: u.id, notification_type: "notification_birthday", extra_data: {} )
	  	  notification.save
	  	end
	  end
	end
end
