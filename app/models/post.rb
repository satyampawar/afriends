class Post < ActiveRecord::Base

	belongs_to :user
	has_many :photoposts  ,:dependent => :destroy
		accepts_nested_attributes_for :photoposts;
	has_many :likes ,:dependent => :destroy
end
