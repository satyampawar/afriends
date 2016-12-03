class UsersController < ApplicationController
	before_filter :authenticate_user!, only: [:update_profile, :fixposition, :cover_pic, :profile_page, :user_details]
  def update_profile
  @user_photo=User.find_by_id(current_user.id)
   render :action => "crop"
  @user_photo.update(user_params)
	 respond_to do |format|
        format.js
  end
end
def photochange()
@user=User.picssi(params[:email_id])
  

  end 
  def fixposition
 
  if params["coverposition"].present?
     @position= params["coverposition"]
     coverposition =current_user.update(:coverpos => params["coverposition"])
   
      respond_to do |format|
    format.js
    end
  end

  end

  def cover_pic

   @user_cover=current_user.update(user_cover)
   respond_to do |format|
    format.js
  end
  end

  def verify_account
    custom_user =  CustomUser.find_by_secret_token(params[:secret_token]) if params[:secret_token]


  end
def profile_page
  @friendlog=Friendlog.new



  @user1=User.find(params[:user_id])
   @friendlogs=Friendlog.where(:friend_id => [@user1.id,current_user.id]).where(:user_id => [@user1_id,current_user.id])

 
  @user=User.new
      @posts=Post.all.order(created_at: :desc)
      @post=Post.new
      @album=Album.new
    @friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
    @user_structure= @user1.structure_json
end

def user_details
@user=User.new
    @user_detail=current_user.update(user_info)
    respond_to do |format|
    format.js
  end
end 



 protected
  
  def user_params
  params.require(:user).permit(:avatar)
  end

  def user_cover
  params.require(:user).permit(:coverpic)
  end

  def user_info
    params.require(:user).permit(:worked_at ,:collage,:school,:live_at,:hometown)
  end
  
end
