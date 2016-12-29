class Post < ActiveRecord::Base

	belongs_to :user
	has_many :tags 
	has_many :photoposts  ,:dependent => :destroy
		accepts_nested_attributes_for :photoposts;
	has_many :likes ,:dependent => :destroy





	def structure_json

    json_data = Array.new

    likes = self.likes.flatten
     
    json_data << {
      :id     => "post_#{self.id}",
      :parent => "#",
      :text   => self.post_name,
      :icon   => "fa fa-square",
      :type   => "post_name"
    }
    
    likes.each do |like|
      json_data << {
        :id     => "like_#{like.id}",
        :parent => "post_#{self.id}",
        :text   => "#{like.user.fullname}: #{like.user.fullname}",
        :icon   => "fa fa-bars",
        :type   => "like"
      }

      # questions = group.questions.active.order("position")
      # questions.each do |question|
      #   json_data << {
      #     :id     => "question_#{question.id}",
      #     :parent => "group_#{group.id}",
      #     :text   => "#{question.name}: #{question.description}",
      #     :icon   => "fa fa-minus",
      #     :type   => "question"
      #   }

      #   items = question.items.active.order("position")
      #   items.each do |item|
      #     json_data << {
      #       :id     => "item_#{item.id}",
      #       :parent => "question_#{question.id}",
      #       :text   => "#{item.name}: #{item.description} (#{item.item_type})",
      #       :icon   => "fa fa-square-o",
      #       :type   => "item"
      #     }

      #     conditions = item.item_conditions.active.order("position")
      #     conditions.each do |condition|
      #       json_data << {
      #         :id     => "item_condition_#{condition.id}",
      #         :parent => "item_#{item.id}",
      #         :text   => "#{condition.name}: #{condition.description} (#{condition.to_string})",
      #         :icon   => "fa fa-question-circle",
      #         :type   => "item_condition"
      #       }

      #       actions = condition.item_actions.active.order("position")
      #       actions.each do |action|
      #         json_data << {
      #           :id     => "item_action_#{action.id}",
      #           :parent => "item_condition_#{condition.id}",
      #           :text   => "#{action.name}: #{action.description} (#{action.to_string})",
      #           :icon   => "fa fa-exclamation-circle",
      #           :type   => "item_action"
      #         }
      #       end
      #     end
      #   end
      end
   
       return json_data.to_json
    end
   








end
