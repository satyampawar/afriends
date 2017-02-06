class VideoChatController < ApplicationController
  require "opentok"
	before_filter :config_opentok,:except => [:index]
	

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
    session = @opentok.create_session
   debugger
    @room = User.find(params[:id])
    @vid = VideoChat.new(caller_id:current_user.id, receiver_id: params[:id],token_base: session.session_id)
    @vid.save
    @tok_token = @opentok.generate_token @vid.token_base
    # redirect_to party_path(@vid.id)
    # respond_to do |format|
    #   format.js
    # end
  end



  def party
    @room = VideoChat.find(params[:id])
    @tok_token = @opentok.generate_token @room.token_base 
  end

  private
  def config_opentok
   if @opentok.nil?
     @opentok = OpenTok::OpenTok.new "45755042", "01e940d50c44c7cd74e176377c6d3f9ef3292eab"
   end
 end
end
