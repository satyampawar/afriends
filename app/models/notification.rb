class Notification < ActiveRecord::Base
	belongs_to :user
	serialize :extra_data, Hash
end
 