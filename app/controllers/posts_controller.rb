class PostsController < ApplicationController
  before_filter :authenticate_user!

  include LastSeenUser
  before_action :tag_names
  before_action :show_all_post 

  def new
  end

  def index
  end

  def create
    @post = current_user.posts.create(post_params)
      if params["post"]["photopst"]
        params["post"]["photopst"].each do |photopst|
        @post.photoposts.create(:photopst => photopst)
        end       
      end
    if request.xhr?
      respond_to do |format|
        format.js
      end
    else
      redirect_to root_path
    end
  end

  def update
  end

  def destroy
    @post=Post.find(params[:id])
    @post.destroy
    respond_to do |format|
        format.js
    end

  end

  def show
  end

  def show_all_post 
     @posts=Post.all.order(created_at: :desc)
  end

  protected
  def post_params
    params.require(:post).permit(:post_name)
  end
  
end
