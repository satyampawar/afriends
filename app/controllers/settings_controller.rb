class SettingsController < ApplicationController
  require 'custom_exception'
  def index
  	@friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
  	@friendlist=current_user.friendlist if user_signed_in?
    @notifications = current_user.notifications if user_signed_in?

    s = @friendlist.map(&:friend_id)
    
    f_f_id = User.where(id: s).collect{|k| k.friendlist}.flatten.map(&:friend_id).uniq - (current_user.friendlist.map(&:friend_id) + current_user.id.to_s[0..1000].split(','))
    @find_friends = User.where(id: f_f_id)
  end

  def block_person
     
  end

  def change_password
    
    begin
      raise  CustomException.new(invalid: "current password is wrong") unless current_user.valid_password?(params[:current_password]) 
      raise  CustomException.new(missmatch: "password doesnt match") unless  params["password"].eql?(params["password_confirmation"])
       if current_user.update_attributes(password: params["password"] ,password_confirmation: params["password_confirmation"])
         flash[:notice]= "password successfully update"
       else
        flash[:notice]= "somethig went wrong"
       end  
    
    rescue Exception => e
      debugger
      
    end
   
  end
end