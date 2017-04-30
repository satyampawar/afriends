class PageInstitute < ActiveRecord::Base
	# has_attached_file :picture, styles: {medium: ["300x300#", :jpg]}, default_url: "/images/:style/missing.png"
 #  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/,
 #    :path => "public/system/:class/:id/:filename",
 #    :url => "/system/:class/:id/:basename.:extension"
   has_attached_file :picture,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")


	belongs_to :page
	belongs_to :post_event
end
