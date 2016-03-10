class FriendlogController < ApplicationController
  def new
  	@friendlog= Friendlog.new
  end

  def create

  	current_user.friendlog.create(friend_id: params["friendlog"]["friend_id"] , status: "req")
    redirect_to user_profile_path(params["friendlog"]["friend_id"].to_i)
  end
  def update

    @friendrqid=params[:id];
    @friendrq=Friendlog.find(params[:id])
    @friendrq.update_attributes(:status => "res")
   @frindlst1=Friendlist.create(:user_id =>current_user.id , :friend_id => params["user_id"])
   @frindlst2=Friendlist.create(:user_id =>params["user_id"], :friend_id => current_user.id)
  respond_to do |format|
    format.js
  end

  end
  def destroy
   @friendrqid=params[:id];

  	@id=params["user_id"].to_i

    @friendlog=Friendlog.destroy(params[:id])
    if request.xhr?
      respond_to do |f|
        f.js
      end
    else  
       redirect_to user_profile_path(@id)
    end
  end
end
