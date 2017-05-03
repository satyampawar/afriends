class Photo < ActiveRecord::Base
	  has_attached_file :pic, styles: {medium: ["300x300#", :jpg]}, :processors => [:file_contents], default_url: "/images/:style/missing.png"
      validates_attachment_content_type :pic, content_type: /\Aimage\/.*\Z/,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"

 
    has_attached_file :pic,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")

	belongs_to :album
	belongs_to :user 
end
