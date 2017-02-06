module PostHelper
	def	post_event_view(post)
		string = " is "
		string += " <img src='/assets/fa-clip.ico' width='20px' style='margin-top:-5px'> "
		string += post.post_event.event_stage1
		string += " <span class='moviename'>"+post.post_event.event_stage2+"</span>"
		string += " at <i class='fa fa-map-marker' style='font-size:18px;'></i>"
		string += " <span class='location'>"+post.post_event.event_stage3+"</span>"
	  string.html_safe
	end

	def post_movie_event_view(post)
		pgm = PageMovie.find(post.post_event.page_id)
		string = "<br><div class='col-md-12'>"
		string += "<div class='col-md-3'><img src='"+pgm.poster_url+"'></div>"
		string += "<div class='col-md-9'><span class='moviename'>"+pgm.title.titleize+"</span><br><span>"+pgm.plot_summary+"</span>"
		string += "<br><span><span class='rating'>"+(pgm.rating/2).to_s+"</span>("+pgm.rating.to_s+")</span>"
		string += "<br><span>Director : "+pgm.director+"</span>"
		string += "<br><span>Release Date : "+pgm.release_date+"</span>"
		string += "</div></div>"
		string.html_safe
	end

	def post_tag(post)
		string = " with "
		post.tags.flatten.each do |pt| 
			# User.find(pt.tag_user_id).map do |u|
			# 	debugger
			# 	string += (u.fullname)
			# end
			string +=	get_fullname pt
		end
		string.html_safe
	end
	def get_fullname pt 
		string = ""
		User.find(pt.tag_user_id).map do |u|
			string += ', ' unless string.empty?
			string += link_to u.fullname, user_profile_path(u.id)

		end
		return string
	end
end
