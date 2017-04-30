class Comment < ActiveRecord::Base
 belongs_to :post

	 has_attached_file :comment_pic,
     :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
   validates_attachment_content_type :comment_pic, :content_type => ["image/jpg", "image/jpeg","image/png"]

end
