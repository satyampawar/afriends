class CommentsController < ApplicationController
	skip_before_action :verify_authenticity_token
  def create
  	post = Post.find params[:post_id]

    @comment = post.comments.new(comment_params.merge(user_id: params[:user_id]))
    @comment.save
  	respond_to do |format|
      format.js
  	end
  end

  def index
  end

  def new
  end

  def destroy
  end

  private
  def comment_params
  params.require(:comment).permit(:comment_name, :comment_pic)
  end
end
