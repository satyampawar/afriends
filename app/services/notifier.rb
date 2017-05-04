class Notifier
  def initialize(user)
    @user = user
  end

  def notify_all_devices
    user.devices.all? do |device|
      send_notification(device)
    end
  end

  private

  attr_reader :user

  def send_notification(device)
    Webpush.payload_send(
      endpoint: device.endpoint,
      p256dh: device.p256dh,
      auth: device.auth,
      cert_store: OpenSSL::X509::Store.new.tap(&:set_default_paths),
      message: message_json,
      api_key: ENV['GCM_MESSAGE_API_KEY']
    )
  rescue => error
    Rails.logger.warn("Error sending browser notification: #{error.inspect}")
    false
  end

  def message_json
    JSON.generate(
      title: "fsafd",
      body: "fsafdsafas",
      url: "localhost:3000"
    )
  end

  # def message_url
  #   host = ENV.fetch("APPLICATION_HOST")

  #   Rails.application.routes.url_helpers.message_url(message, host: host)
  # end
end
