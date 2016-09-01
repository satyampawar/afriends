require 'rubygems'
require 'twilio-ruby'
class PhoneNumbersController < ApplicationController
  def new
  	@phone_number =PhoneNumber.new
  end
def create
	
  @phone_number = PhoneNumber.find_or_create_by(mobile_number: current_user.phone_number)
  @phone_number.generate_pin
  @phone_number.send_pin
  redirect_to new_verify_path
  
end

def new_verify
	
	
end

  def verify
  @phone_number = PhoneNumber.find_by_mobile_number(current_user.phone_number)
  @phone_number.verify(params[:pin])
  respond_to do |format|
    format.js
  end
end


end
