class Page < ActiveRecord::Base
	has_one :page_institute
	has_one :page_movie
	belongs_to :user
end
