class CustomException < StandardError
  attr_reader :data
  def initialize(data)
    super(data)
  end

 
end