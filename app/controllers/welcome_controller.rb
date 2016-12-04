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

def get_ip_machine
	debugger
	 ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
     ip = ip.ip_address
     Geokit::Geocoders::IpGeocoder.geocode(ip.to_s())
    respond_to do |format|
      format.json { 
        render json: ip
      }
    end
end


def who_is_online
  @friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
  @friendlist=current_user.friendlist
  respond_to do |format|
    format.js
  end
end

def change_emotion
  emotion = params[:emo_id].to_i
  @results = [];
  case emotion
 when 1

 # 	@results = [["happy", 1, {"data-image"=>"http://www.hdwallpapers.in/walls/love_hearts_abstract_valentine-wide.jpg"}],
	# ["crezy", 2, {"data-currency_code"=>""}],
	# ["sad", 3, {"data-currency_code"=>"jain"}]]

	@results = [{ id: 0, text: 'enhancement' }, { id: 1, text: 'bug' }, { id: 2, text: 'duplicate' }];
	# @results = JSON.parse(@results)
 when 2
  "It's 6"
 when 3
  "You passed a string"
 else
  "You gave me #{a} -- I have no idea what to do with that."
 end
 respond_to do |format|
    format.js
  end
end

end
