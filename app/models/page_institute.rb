class PageInstitute < ActiveRecord::Base
	has_attached_file :picture, styles: {medium: ["300x300#", :jpg]}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"

	belongs_to :page
end
