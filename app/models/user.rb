class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable

 has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"


 has_attached_file :coverpic, styles: { medium: "800x600>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :coverpic, content_type: /\Aimage\/.*\Z/,
    :path => "public/system/:class/:id/:filename",
    :url => "/system/:class/:id/:basename.:extension"


  has_many :likes
  has_many :posts ,:dependent => :destroy
  has_many :albums , :dependent => :destroy
  has_many :photos
  has_many :friendlog
  has_many :friendlist
  
  has_many :conversations, :foreign_key => :sender_id

 
def self.picssi email

 @userimage=self.find_by_email(email).avatar.url
 return @userimage
end

def fullname
       "#{first_name}  #{last_name}"         

end
end
