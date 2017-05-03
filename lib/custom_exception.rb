class CustomException < StandardError
  attr_reader :data
  def initialize(data)
  	debugger
    @data = data
    super(data)
  end

   def to_s
       "[#{data}] #{super}"
   end
end