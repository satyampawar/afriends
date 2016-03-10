class Photopost < ActiveRecord::Base
	has_attached_file :photopst, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :photopst, content_type: /\Aimage\/.*\Z/,
		:path => "public/system/:class/:id/:filename",
		:url => "/system/:class/:id/:basename.:extension"
	belongs_to :post
	accepts_nested_attributes_for :post;
end
