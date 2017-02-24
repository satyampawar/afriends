class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
  after_save :notification_like

	def notification_like

		notification = 	Notification.new(user_id: self.post.user_id,notifier_id: self.user_id, extra_data: {likeid: self.id} , notification_type: "notification_like" )
		notification.save
		self.post.tags.map(&:tag_user_id).flatten.each do |tag_user_id|
			notification = 	Notification.new(user_id: tag_user_id, notifier_id: self.user_id, extra_data: {likeid: self.id} , notification_type: "notification_like" )
			notification.save 
		end
	end
end
