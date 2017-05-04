class DevicesController < ApplicationController
  
  def index
    @devices = current_user.devices.order(:created_at)
  end

  def create
    existing_device = current_user.devices.find_by(endpoint: device_params[:endpoint])

    if existing_device
      render json: existing_device, status: :ok and return
    end

    device = current_user.devices.build(device_params.merge user_agent: request.user_agent)

    if device.save
      render json: device, status: :created
    else
      render json: { errors: device.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    device = current_user.devices.find_by! endpoint: Base64.decode64(params[:id])

    if device.destroy
      head :no_content
    else
      render json: { errors: device.errors }, status: :unprocessable_entity
    end
  end

  private

  def device_params
    params.require(:device).permit(:endpoint, :p256dh, :auth)
  end
end
