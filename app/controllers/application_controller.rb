class ApplicationController < ActionController::Base
 

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :fullname
  include LastSeenUser
  before_action :set_last_seen
  


def fullname
  fullname="#{current_user.first_name}" ' ' "#{current_user.last_name}" 
  return fullname;
end

  # before_action :configure_permitted_parameters ,if: :devise_controller?
  
  #   def after_sign_inpath_for(resource)
  #   binding.pry
  # end
  # def after_sign_up_path_for(resource)
  #   binding.pry
  # end
  # def after_update_path_for(resource)
  #   binding.pry

  # end
  # protected

  #   def configure_permitted_parameters
  #     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name,:last_name,:email, :password,:confirm_password) }
  #   end
  
  
  #  helper_method :resource,:resource_name,:devise_mapping
	# def resource_name
	# 	:user
	# end


	# def resource_name
	# 	:user
	# end

	# def resource
	# 	@resource||= User.new
		
	# end
	# def devise_mapping
	# 	# @devise_mapping||= Devise_mapping[:user]

	# end

end
