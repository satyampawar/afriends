class UsersController < ApplicationController
  include ApplicationHelper
	before_filter :authenticate_user!, only: [:update_profile, :fixposition, :cover_pic, :profile_page, :user_details, :create_page]
  before_action :notification

  def notification
     @notifications = current_user.notifications if user_signed_in?
  end


  def update_profile
  @user_photo=User.find_by_id(current_user.id)
   render :action => "crop"
  @user_photo.update(user_params)
	 respond_to do |format|
        format.js
  end
end
def photochange()
@user=User.picssi(params[:email_id])
  

  end 
  def fixposition
 
  if params["coverposition"].present?
     @position= params["coverposition"]
     coverposition =current_user.update(:coverpos => params["coverposition"])
   
      respond_to do |format|
    format.js
    end
  end

  end

  def cover_pic

   @user_cover=current_user.update(user_cover)
   respond_to do |format|
    format.js
  end
  end

  def verify_account
    custom_user =  CustomUser.find_by_secret_token(params[:secret_token]) if params[:secret_token]


  end
def profile_page
  @friendlog=Friendlog.new



  @user1=User.find(params[:user_id])
   @friendlogs=Friendlog.where(:friend_id => [@user1.id,current_user.id]).where(:user_id => [@user1_id,current_user.id])

 @notifications = current_user.notifications if user_signed_in?
  @user=User.new
      @posts=Post.all.order(created_at: :desc)
      @post=Post.new
      @album=Album.new
    @friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
    @user_structure= @user1.structure_json
end

def user_details
@user=User.new
    @user_detail=current_user.update(user_info)
    respond_to do |format|
    format.js
  end
end 

def create_page
  if params[:commit] == nil
    @page = Post.new
    @friendlog=Friendlog.new
    @user1=User.find(params[:user_id])
    @friendlogs=Friendlog.where(:friend_id => [@user1.id,current_user.id]).where(:user_id => [@user1_id,current_user.id])
    # @notifications = current_user.notifications
    @user=User.new
    @posts=Post.all.order(created_at: :desc)
    @post=Post.new
    @album=Album.new
    @friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
    @user_structure= @user1.structure_json
  else
    debugger
  end
end

def search_movies
  results = Imdb::Search.new(params[:movie_name])
  if results.movies.size > 0
    # http = Net::HTTP.new(URI.parse(f.url).host, uri.port)
    # request = Net::HTTP::Get.new(URI.parse(f.url).request_uri)
    # response = http.request(request)
    # URI.extract(response.body).collect{|a| a.include?('.jpg') ? a.include?('amazon') ? a: nil : nil}.compact.first
    data = results.movies[0..2].map{
      |f| 
    http = Net::HTTP.new(URI.parse(f.url).host, URI.parse(f.url).port)
    request = Net::HTTP::Get.new(URI.parse(f.url).request_uri)
    response = http.request(request)
    video_id = response.body.split.collect{|a| a.include?('data-video') ? a:nil }.compact.first.split("=").second.gsub("\"","") rescue nil

    image_url = URI.extract(response.body).collect{|a| a.include?('.jpg') ? a.include?('amazon') ? a: nil : nil}.compact.first
    video_url = video_id.present? ? "http://www.imdb.com/title/tt#{f.id}/videoplayer/#{video_id}?ref_=tt_ov_vi" : nil
    # extra_data = {'title'=> f.title,'rating' => f.rating ,'director' => f.director,'year' => f.year, 'votes' => f.votes, 'release_date' => f.release_date}
      [
        "<img src= #{image_url} width='120px' height='120px'>",
        f.title,
        f.rating,
        "<input type='radio' name='movies' class='radio-btn' onclick='setValue(#{f.id})' value='#{f.id}'><input type='hidden' id='psm_#{f.id}' name='plot_summary' value='#{f.plot_summary}'>
        <input type='hidden' id='img_#{f.id}' name='image_url' value='#{image_url}'><input type='hidden' id='video_#{f.id}' name='video_url' value='#{video_url}'>
         <input type='hidden' id='title_#{f.id}' name='title' value='#{f.title}'><input type='hidden' id='rating_#{f.id}' name='rating' value='#{f.rating}'>
          <input type='hidden' id='director_#{f.id}' name='director' value='#{f.director.first}'><input type='hidden' id='year_#{f.id}' name='year' value='#{f.year}'>
           <input type='hidden' id='votes_#{f.id}' name='votes' value='#{f.votes}'><input type='hidden' id='release_date_#{f.id}' name='release_date' value='#{f.release_date}'>"
      ]}
    render :json => data
  else
    render :json => {data: nil}
  end
end

def friends_list
  users = User.where("first_name ilike ?","#{params[:filter]}%")
  # users = users.where("last_name ilike ?","#{params[:filter][1..params[:filter].split.count].join('')}%") if params[:filter].split[1].present?

  friends = users.where("id IN (?)",current_user.friendlist.map(&:friend_id)).collect{|a| [id: a.id, name: a.first_name, image_url: user_picture_url(a,"imgss","[ img-circle pull-left ]",48), created_at: a.created_at, updated_at: a.updated_at]}.flatten
  #friends = User.where(id: (current_user.friendlist.map(&:friend_id))).select(:first_name, :email, :id)
    respond_to do |format|
      format.json { render :json => friends }
    end
end


 protected
  
  def user_params
  params.require(:user).permit(:avatar)
  end

  def user_cover
  params.require(:user).permit(:coverpic)
  end

  def user_info
    params.require(:user).permit(:worked_at ,:collage,:school,:live_at,:hometown)
  end
  
end
