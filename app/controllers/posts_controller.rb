class PostsController < ApplicationController
  def new
  end

  def index
    @posts=Post.all.order(created_at: :desc)
  end

  def create
    @posts=Post.all.order(created_at: :desc)
    @post = current_user.posts.create(post_params)
    binding.pry
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
    @posts=Post.all

    @post=Post.destroy(params[:id])
    @post.destroy
    respond_to do |format|
        format.js
    end

  end

  def show
  end

  protected
  def post_params
    params.require(:post).permit(:post_name)
  end
  
end
