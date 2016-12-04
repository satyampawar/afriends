class ActiveRecord::Base
  before_create :check 
  def check
    debugger 
  end 


  def self.is_active *actions
    debugger
  end
end
