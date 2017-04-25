class PostsController < ApplicationController
  before_filter :authenticate_user!

  include LastSeenUser
  include ApplicationHelper

  before_action :show_all_post
  before_action :set_notification, :only => :show 

  def new
  end

  def index
  end

  def create
    # post_params[:post_name].partition('@').last.split[0..2][0..1].join(' ')
    post_params[:post_name]
    @post = current_user.posts.create(post_params)
      if params["post"]["photopst"]
        params["post"]["photopst"].each do |photopst|
        @post.photoposts.create(:photopst => photopst)
        end       
      end
      if params['event_type'].present?
       post_event_params =  {page_id: params[:page_id],event_string: params[:event_string], event_type: params[:event_type] ,event_stage1: params[:event_stage1],event_stage2: params[:event_stage2],event_stage3:  params[:event_stage3]}
        @post_event = @post.build_post_event post_event_params
        @post_event.save
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
     @notifications = current_user.notifications if user_signed_in?

  end

  def show_all_post 
     @posts=Post.all.order(created_at: :desc)
  end

  def set_notification
    if params[:notific].present?
     Notification.find(params[:notific]).update(is_read: true)
    end
  end

  protected
  def post_params
    params.require(:post).permit(:post_name)
  end
  
end
