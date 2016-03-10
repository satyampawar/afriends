class RegistrationsController < Devise::RegistrationsController

  private
 def after_inactive_sign_up_path_for(resource)
    
      "/phone_numbers/create"

    # Or :prefix_to_your_route
  end

 def after_sign_up_path_for(resource)
  	
      "/phone_numbers/create"

    # Or :prefix_to_your_route
  end
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,:phone_number)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password,:phone_number)
  end
end
#   def new
#     super
#   end

#   def create
  
#   end

#   def edit
#   end

#   def update
#   end

#   def destroy
#   end
# end
