class Page < ActiveRecord::Base
	has_one :page_institute
	has_one :page_movie , dependent: :destroy
	belongs_to :user
end
