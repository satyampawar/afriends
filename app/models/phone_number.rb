class PhoneNumber < ActiveRecord::Base
def generate_pin

  self.pin = rand(0000..9999).to_s.rjust(4, "0")
  save
end

def send_pin

twilio_client=Twilio::REST::Client.new("AC375313aa22e4dc06118d018b9574e14e","4b82ae77799540f89195fe8c758737fe")

 twilio_client.messages.create(to: self.mobile_number,from: '+15033885802',body: "Your PIN is #{pin}")
end


def verify(entered_pin)
  update(verified: true) if self.pin == entered_pin
end
end
