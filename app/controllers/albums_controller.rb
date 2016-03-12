class AlbumsController < ApplicationController
  def create
    @user1=current_user
   
    album=current_user.albums.create(album_param)
    respond_to do |format|
      format.js
      
    end
  end

  def index

 
    @user1=User.find(params[:user_id])
    @album=@user1.albums

    if request.xhr?
      respond_to do |format|
      format.js
      
    end
    end
  end

  def new
  end

  def destroy
  end

  def show
  
    @user1=User.find(params[:user_id])
    @album=Album.find(params[:id])
    @photos=Photo.where(album_id: params[:id])
    respond_to do |format|
      format.js
    end
  end

  protected
  def album_param
    params.require(:album).permit(:album_name)
  end
  
end
