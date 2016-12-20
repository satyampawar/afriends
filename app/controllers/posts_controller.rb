class PostsController < ApplicationController
  before_filter :authenticate_user!

  include LastSeenUser

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
    @post = Post.find(params[:id])
    @friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
    @friendlist=current_user.friendlist if user_signed_in?
    s = @friendlist.map(&:friend_id)
    f_f_id = User.where(id: s).collect{|k| k.friendlist}.flatten.map(&:friend_id).uniq - (current_user.friendlist.map(&:friend_id) + current_user.id.to_s[0..1000].split(','))
    @find_friends = User.where(id: f_f_id)
    @tags = Tag.where(post_id: params[:id])
    @tag_users = @tags.collect{|k| User.where(id: k.tag_user_id)}.flatten

  end

  def show_all_post 
     @posts=Post.all.order(created_at: :desc)
  end

  protected
  def post_params
    params.require(:post).permit(:post_name)
  end
  
end
