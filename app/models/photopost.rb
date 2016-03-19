class Photopost < ActiveRecord::Base

	# has_attached_file :photopst, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
 #    validates_attachment_content_type :photopst, content_type: /\Aimage\/.*\Z/,
	# 	:path => "public/system/:class/:id/:filename",
	# 	:url => "/system/:class/:id/:basename.:extension"
binding.pry


	has_attached_file :photopst, 
	 styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png",
    :storage => :google_drive,
    :google_drive_credentials => "#{Rails.root}/config/google_drive.yml",


      :google_drive_options => {
      	:path => proc { |style| "#{style}_#{id}_#{photopst.original_filename}" },
          :public_folder_id =>'0B4d-BosofnhbZncyNG1kbUM3bFE',
          
    }

	belongs_to :post
	accepts_nested_attributes_for :post;


	# has_attached_file :photopst, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png",
 #    :storage => :google_drive,
 #    :google_drive_credentials => "#{Rails.root}/config/google_drive.yml"

end
