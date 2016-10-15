class PhotosController < ApplicationController
  def create
debugger
    @user1=current_user
    @album=params[:album_id];
    @photos=Photo.where(:album_id => @album)
    if  params["photo"]["pic"].present?
     
       params["photo"]["pic"].each do |pic|
    
          @photo=current_user.photos.new(:pic =>  pic,:album_id => @album)
          @photo.save
       end
      respond_to do |format|
       format.js
      end
    end
  end

  def index
  end

  def new
  end

  def destroy
  end

  def show
  end

    protected
  def photo_param
    params.require(:photo).permit(:pic)
  end
end
