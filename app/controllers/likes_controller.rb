class LikesController < ApplicationController
  before_filter :authenticate_user!
  def new
  end

  def create
    debugger
    @posts=Post.all.order(created_at: :desc)
    likes = current_user.likes.where(:post_id => params["post_id"]).first_or_create
    likes.update_attributes(emotion: params[:emotions])
    debugger
    @like = likes
    respond_to do |format| 
     format.js
    end
  end

  def index
  end

  def show
  end

  def destroy
    @posts=Post.all.order(created_at: :desc)
     @like = Like.find(params["id"])
      respond_to do |format| 
      @like.destroy
     format.js
   end
    
     
  end
end
