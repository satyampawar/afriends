class TagsController < ApplicationController
	# before_action :tag_user, only: [:create]

	# def tag_user
	# 	@tags = Tag.where(post_id: params[:post_id])
	# 	@tag_users = @tags.collect{|k| User.where(id: k.tag_user_id)}.flatten
	# end

	def create
		
		post_id = params[:post_id]
		@post_id = post_id
		user_id = params[:user_id]
		tag_user_id = params[:tag_user_id]
		tag = Tag.find_by_user_id_and_post_id(user_id,post_id)
		if tag.present?
		 tag_user_id = tag.tag_user_id + tag_user_id
		 tag.update(tag_user_id: tag_user_id)
		else
		   tag = Tag.new(post_id: post_id, user_id: user_id ,tag_user_id: tag_user_id)
		   tag.save
		end
		@tags = Tag.where(post_id: params[:post_id])
		@tag_users = @tags.collect{|k| User.where(id: k.tag_user_id)}.flatten
		
		respond_to do |format|
			format.js
		end
	end


	def remove_tag_user
		array = []
		array.push(params[:user_id])
		tags = current_user.tags.where(post_id: params[:post_id]).flatten
		tag_user_id = tags.collect{|k| k.tag_user_id}.flatten - array
		tags.select{|k| k.tag_user_id}.flatten.first.update_attributes(tag_user_id:tag_user_id)
		@tags = Tag.where(post_id: params[:post_id])
		@tag_users = @tags.collect{|k| User.where(id: k.tag_user_id)}.flatten
		respond_to do |format|
			format.js
		end
	end

	private
	# def tag_params
	#  params.require(:tag).permit(:user_id,:post_id,:tag_user_id)
	# end
end
