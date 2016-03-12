class WelcomeController < ApplicationController
  def index
   
  	@user=User.new
  	@posts=Post.all.order(created_at: :desc)
  	@post=Post.new
  	@friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
  	@friendlist=current_user.friendlist if user_signed_in?
  end
end
