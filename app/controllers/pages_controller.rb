class PagesController < ApplicationController
	before_action :nav_content , only: :show
	def create
		page_type = params[:page_type]
		case page_type
		when "inst"
			inst_page params
		end
		redirect_to user_page_path(@main_page)
	end

	def show
		@page = Page.find(params[:id])
	end


	def inst_page params
		@main_page = Page.new(user_id: params[:user_id], page_type: params[:page_type],title: params[:title])
		if @main_page.save
			page_params = {"lats" => params[:lats],"long"=> params[:longs], "address" => params[:address], "page_id" => @main_page.id,"picture" => params[:picture] }
			debugger
			@second_page = page.build_page_institute page_params
			@second_page.save
		end
	end

	def nav_content
	  @friendreq=Friendlog.where(:friend_id => current_user).where(:status => "req") 
  	@friendlist=current_user.friendlist if user_signed_in?
    s = @friendlist.map(&:friend_id)
    f_f_id = User.where(id: s).collect{|k| k.friendlist}.flatten.map(&:friend_id).uniq - (current_user.friendlist.map(&:friend_id) + current_user.id.to_s[0..1000].split(','))
    @find_friends = User.where(id: f_f_id)
  end

end