module PagesHelper
	def page_movie_helper(p)
		html = ""
		html += image_tag(p.page_movie.poster_url ,id: 'imgss',class: 'img-responsive background col-md-3', width: '45px', style: 'padding:0;') 
		html +=	"<div class='col-md-9'><a href ='#'>#{p.page_movie.title}</a>"
		html += "</br><span style='font-size:11.2px;'>Director: #{p.page_movie.director} <br> Rating: #{p.page_movie.rating}</span></div>"
	  html.html_safe
	end

	def page_inst_helper(p)
		html = ""
		html += image_tag(p.page_institute.picture_url ,id: 'imgss',class: 'img-responsive background col-md-3', width: '45px', style: 'padding:0;') 
		html +=	"<div class='col-md-9'><a href ='#'>#{p.page_institute.name}</a>"
		# html += "</br><span style='font-size:11.2px;'>Director: #{p.page_movie.director} <br> Rating: #{p.page_movie.rating}</span></div>"
	  html.html_safe
	end
end