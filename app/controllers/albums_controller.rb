class AlbumsController < ApplicationController
  before_filter :authenticate_user!

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
    @album = Album.find(params[:album_id])
    if @album.pin == params[:pin]
      @album.destroy
    elsif @album.pin.nil? || @album.pin == ""
      @album.destroy
      #render :status => 200, :text => "OK"
    else
      #render :status => 403, :text => "Forbidden"
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @user1=User.find(params[:user_id])
    @album=Album.find(params[:id])
    @photos=Photo.where(album_id: params[:id])
    respond_to do |format|
      format.js
    end
  end

  def lock_album
    @album = Album.find(params[:album_id])
    if @album.pin == params[:pin]
      if @album.locked == "Yes"
        @album.update(:locked => "No")
        @msg = "Album is un-locked !"
      else
        @album.update(:locked => "Yes")
        @msg = "Album is locked !"
      end
    elsif @album.pin.nil?
      @album.pin = params[:pin]
      if @album.locked == "Yes"
        @album.locked = "No"
        @msg = "Album is locked !"
      else
        @album.locked = "Yes"
        @msg = "Album is un-locked !"
      end
      @album.save
      #render :status => 200, :text => "OK"
    else
      @msg = "Entered Pin is in-correct !"
      #render :status => 403, :text => "Forbidden"
    end
    respond_to do |format|
      format.js
    end
  end

  protected
  def album_param
    params.require(:album).permit(:album_name)
  end
  
end
