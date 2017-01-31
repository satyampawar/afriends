class Post < ActiveRecord::Base

	belongs_to :user
	has_many :tags 
	has_many :photoposts  ,:dependent => :destroy
		accepts_nested_attributes_for :photoposts;
	has_many :likes ,:dependent => :destroy





	def structure_json

    json_data = Array.new

    # likes = self.likes.flatten
    today_likes = self.likes.where(updated_at: (Time.zone.now.beginning_of_day - 1.day)..Time.zone.now.end_of_day)
    yesterday_likes = self.likes.where(updated_at: (Time.zone.now.beginning_of_day - 2.days)..(Time.zone.now.end_of_day - 1.day))
    this_weeks = self.likes.where(updated_at: (Time.zone.now.beginning_of_day - 7.days)..(Time.zone.now.end_of_day))
    week_ago = self.likes.where(updated_at: (Time.zone.now.beginning_of_day - 14.days)..(Time.zone.now.end_of_day - 7.days))
    this_month = self.likes.where(updated_at: (Time.zone.now.beginning_of_day - 30.days)..(Time.zone.now.end_of_day - 14.days))
    

     format_array = ["today_likes","yesterday_likes","this_weeks","week_ago","this_month"]
    
    
     
    json_data << {
      :id     => "post_#{self.id}",
      :parent => "#",
      :text   => self.post_name,
      :icon   => "fa fa-square",
      :type   => "post_name"
    }
    
    format_array.each do |format_date|
      json_data << {
        :id     => "#{format_date}_#{self.id}",
        :parent => "post_#{self.id}",
        :text   => "#{format_date}",
        :icon   => "fa fa-bars",
        :type   => "#{format_date}"
      }
      eval(format_date).flatten.each do |like|
      json_data << {
        :id     => "like_#{like.id}",
        :parent => "#{format_date}_#{self.id}",
        :text   => "#{like.user.fullname}",
        :icon   => "fa fa-bars",
        :type   => "like"
      }
        end
      end
       return json_data.to_json
    end
   








end
