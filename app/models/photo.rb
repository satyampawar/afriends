class Photo < ActiveRecord::Base
	  has_attached_file :pic, styles: { medium:"300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :pic, content_type: /\Aimage\/.*\Z/,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"

	belongs_to :album
	belongs_to :user 
end
