class WelcomeController < ApplicationController
  def index
   
  	@user=User.new
  	@posts=Post.all.order(created_at: :desc)
  	@post=Post.new
  	@friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
  	@friendlist=current_user.friendlist if user_signed_in?
  	@event =[
							["Feeling", 1, {"data-image"=>"http://www.hdwallpapers.in/walls/love_hearts_abstract_valentine-wide.jpg"}],
							["Watching", 2, {"data-currency_code"=>""}],
							["Celebrating", 3, {"data-currency_code"=>"jain"}],
							["Listing", 4, {"data-currency_code"=>"jain"}], 
							["More", 5, {"data-currency_code"=>""}],
							["Thinking about",6,{"data-currency_code"=>"jain"}],
							["Treveling to", 7,{"data-currency_code"=>"jain"}],
							["Attending to",8,{"data-currency_code"=>"jain"}],
							["Getting" ,9,{"data-currency_code"=>"jain"}],
							["Plaining",10,{"data-currency_code"=>"jain"}],
							["Reading",11,{"data-currency_code"=>"jain"}],
							["Eating",12,{"data-currency_code"=>"jain"}],
						] 

  end
end
