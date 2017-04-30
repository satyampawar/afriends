class Photopost < ActiveRecord::Base

	# has_attached_file :photopst, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 #    validates_attachment_content_type :photopst, content_type: /\Aimage\/.*\Z/,
	# 	:path => "public/system/:class/:id/:filename",
	# 	:url => "/system/:class/:id/:basename.:extension"

	belongs_to :post
	accepts_nested_attributes_for :post;

 
	# has_attached_file :photopst, 
	#  styles: { original: "700x700>" }, default_url: "/images/:style/missing.png" 
	#  validates_attachment_content_type :photopst, content_type: /\Aimage\/.*\Z/,
 #    :storage => :google_drive,
 #    :google_drive_credentials => "#{Rails.root}/config/google_drive.yml",
 #      :google_drive_options => {
 #      	:path => proc { |style| "#{style}_#{id}_#{photopst.original_filename}" },
 #          :public_folder_id =>'0B3-wKP83_thWanZaVlJSUGxYLW8',
          
 #    }

      has_attached_file :photopst,
     #validates_attachment :photopst, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },

       :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
   validates_attachment_content_type :photopst, :content_type => ["image/jpg", "image/jpeg","image/png"]

	# has_attached_file :photopst, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png",
 #    :storage => :google_drive,
 #    :google_drive_credentials => "#{Rails.root}/config/google_drive.yml"

end
