class PageMovie < ActiveRecord::Base
	belongs_to :page
	belongs_to :post_event
end
