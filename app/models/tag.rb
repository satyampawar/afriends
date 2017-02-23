class Tag < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	serialize :tag_user_id, Array
	after_save :notification_tag


	def notification_tag
		self.tag_user_id.each do |tag|
			notification = 	Notification.new(user_id: tag.to_i,notifier_id: self.user_id, notification_type: "notification_tag" )
			notification.save
		end
	end
end
