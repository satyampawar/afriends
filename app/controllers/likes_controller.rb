class LikesController < ApplicationController
  before_filter :authenticate_user!
  def new
  end

  def create
    @posts=Post.all.order(created_at: :desc)
    @like = current_user.likes.new(:post_id => params["post_id"])
    respond_to do |format| 
     @like.save
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
