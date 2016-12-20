class Tag < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	serialize :tag_user_id, Array
end
