class User < ActiveRecord::Base
# before_destroy   :load_into_soulmate
# after_save   :remove_from_soulmate
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable, :lastseenable

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
  has_many :tags
  has_many :pages
  
  has_many :conversations, :foreign_key => :sender_id

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

 
def self.picssi email

 @userimage=self.find_by_email(email).avatar.url
 return @userimage
end
def fullname
  "#{first_name}  #{last_name}"         

end


def self.from_omniauth(auth)
    # @user ||= User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    # if !@user.persisted?
    logger.info auth
    user = self.find_by_email(auth.info.email)
    if !auth.info.email.present?
      user = self.find_by_email(auth.uid+"@facebook.com")
      if !user
      user = User.create!(email: auth.uid+"@facebook.com",
                       password: Devise.friendly_token[0,20],
                       first_name: auth.info.name,
                       last_name: "",
                       img_url: auth.info.image+"?type=large",
                       provider: auth.provider,
                       uid: auth.uid)
      end
      user
    
    elsif user.present?
      user
    else
      user = where(email: auth.info.email).first
      user = User.create!(email: auth.info.email,
                       password: Devise.friendly_token[0,20],
                       first_name: auth.info.name,
                       last_name: "",
                       img_url: auth.info.image+"?type=large",
                       provider: auth.provider,
                       uid: auth.uid)
      user
    end
    # else
    #   sign_in_and_redirect @user, event: :authentication
    #         if is_navigational_format?
    #             set_flash_message(:notice, :success, kind: "Facebook")
    #         end
    # end
  end

def structure_json

    json_data = Array.new

    posts = self.posts

    json_data << {
      :id     => "user_#{self.id}",
      :parent => "#",
      :text   => fullname,
      :icon   => "fa fa-square",
      :type   => "user"
    }

    posts.each do |post|
      json_data << {
        :id     => "post_#{post.id}",
        :parent => "form_#{post.user.id}",
        :text   => "#{post.post_name}: #{post.post_name}",
        :icon   => "fa fa-bars",
        :type   => "post"
      }

      # questions = group.questions.active.order("position")
      # questions.each do |question|
      #   json_data << {
      #     :id     => "question_#{question.id}",
      #     :parent => "group_#{group.id}",
      #     :text   => "#{question.name}: #{question.description}",
      #     :icon   => "fa fa-minus",
      #     :type   => "question"
      #   }

      #   items = question.items.active.order("position")
      #   items.each do |item|
      #     json_data << {
      #       :id     => "item_#{item.id}",
      #       :parent => "question_#{question.id}",
      #       :text   => "#{item.name}: #{item.description} (#{item.item_type})",
      #       :icon   => "fa fa-square-o",
      #       :type   => "item"
      #     }

      #     conditions = item.item_conditions.active.order("position")
      #     conditions.each do |condition|
      #       json_data << {
      #         :id     => "item_condition_#{condition.id}",
      #         :parent => "item_#{item.id}",
      #         :text   => "#{condition.name}: #{condition.description} (#{condition.to_string})",
      #         :icon   => "fa fa-question-circle",
      #         :type   => "item_condition"
      #       }

      #       actions = condition.item_actions.active.order("position")
      #       actions.each do |action|
      #         json_data << {
      #           :id     => "item_action_#{action.id}",
      #           :parent => "item_condition_#{condition.id}",
      #           :text   => "#{action.name}: #{action.description} (#{action.to_string})",
      #           :icon   => "fa fa-exclamation-circle",
      #           :type   => "item_action"
      #         }
      #       end
      #     end
      #   end
      end
       return json_data.to_json
    end
   
  private 

  
  def reprocess_avatar
    avatar.reprocess!
  end
  # def load_into_soulmate
  #   loader = Soulmate::Loader.new("users")
  #   loader.add("term" => name, "id" => self.id, "data" => {
  #     "link" => Rails.application.routes.url_helpers.user_path(self)
  #     })
  # end

  # def remove_from_soulmate
  #   loader = Soulmate::Loader.new("users")
  #     loader.remove("id" => self.id)
  # end
end

