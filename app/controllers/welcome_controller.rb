class WelcomeController < ApplicationController
  include ApplicationHelper
  include PagesHelper
  include PostHelper
  def index
  	@user=User.new
  	@posts=Post.all.order(created_at: :desc)
  	@post=Post.new
  	@friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
  	@friendlist=current_user.friendlist if user_signed_in?

    s = @friendlist.map(&:friend_id)
    
    f_f_id = User.where(id: s).collect{|k| k.friendlist}.flatten.map(&:friend_id).uniq - (current_user.friendlist.map(&:friend_id) + current_user.id.to_s[0..1000].split(','))
    @find_friends = User.where(id: f_f_id)

    
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

def search_user
  query = params[:search_letter]
  unless query == ""
    users = User.where("first_name Like ?","#{query.split[0]}%")
    users = users.where("last_name Like ?","#{query.split[1..query.split.count].join('')}%") if query.split[1].present?
    @users = users
    respond_to do |format|
      format.js
    end
  else

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
	@stage_1=nil
  # @results = JSON.parse(@results)
 when 2
  @results = current_user.pages.flatten
  @stage_1 = "Watching movie .."
 when 3
  "You passed a string"
  @stage_1 =nil
 else
  "You gave me #{a} -- I have no idea what to do with that."
  @stage_1 =nil
 end
 respond_to do |format|
    format.js
  end
end

def second_change_emotion
  
  emotion = params[:emo_id]
  @statge =   params[:parent_stage].to_i
  case @statge
  when 2
    @movie = PageMovie.find(params[:emo_id])
    @results = ["1","Inox Indore"]
  end
  respond_to do |format|
    format.js
  end

end

def create_page
  @page = Post.new
  @friendlog=Friendlog.new



  @user1=User.find(params[:user_id])
   @friendlogs=Friendlog.where(:friend_id => [@user1.id,current_user.id]).where(:user_id => [@user1_id,current_user.id])

 
  @user=User.new
      @posts=Post.all.order(created_at: :desc)
      @post=Post.new
      @album=Album.new
    @friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
    @user_structure= @user1.structure_json
end

end
