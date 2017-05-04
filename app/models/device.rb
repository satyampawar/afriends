class Device < ActiveRecord::Base
belongs_to :user
validates :endpoint, presence: true, uniqueness: true

  delegate :name, :version, :platform, :device, to: :parsed_user_agent, prefix: :ua

  def parsed_user_agent
    @parsed_user_agent ||= Browser.new(user_agent)
  end 
end
