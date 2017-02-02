class VideoChatController < ApplicationController
require "opentok"
before_filter :config_opentok,:except => [:index]
  # def index
  #   @rooms = Room.where(:public => true).order("created_at DESC")
  #   @new_room = Room.new
  # end

  # def create
  #   session = @opentok.create_session request.remote_addr
  #   params[:room][:sessionId] = session.session_id

  #   @new_room = Room.new(params[:room])

  #   respond_to do |format|
  #     if @new_room.save
  #       format.html { redirect_to("/party/"+@new_room.id.to_s) }
  #     else
  #       format.html { render :controller => 'rooms',
  #         :action => "index" }
  #     end
  #   end
  # end

  def setting_up
  	@friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
  	@friendlist=current_user.friendlist if user_signed_in?

    s = @friendlist.map(&:friend_id)
    
    f_f_id = User.where(id: s).collect{|k| k.friendlist}.flatten.map(&:friend_id).uniq - (current_user.friendlist.map(&:friend_id) + current_user.id.to_s[0..1000].split(','))
    @find_friends = User.where(id: f_f_id)
    debugger
    session = @opentok.create_session request.remote_addr
    @room = User.find(params[:id])
    @vid = VideoChat.new(caller_id:current_user.id, receiver_id: params[:id])
    @vid.save
    # respond_to do |format| 
    #  format.js
    # end

     @tok_token = @opentok.generate_token :session_id =>params[:id]     
  end

  private
  def config_opentok
    if @opentok.nil?
     @opentok = OpenTok::OpenTok.new 45756982, "2e31dca658d57ab6cdd2fd46d6ae8637739eb41d"
    end
  end

end
