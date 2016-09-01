module ApplicationHelper
	def post_photo(user_id,photo)
      image_tag("https://googledrive.com/host/0B3-wKP83_thWanZaVlJSUGxYLW8/original_"+user_id.to_s+"_"+photo)
    # image_tag("https://googledrive.com/host/0B3-wKP83_thWanZaVlJSUGxYLW8/medium_22_PicsArt_1433932787086_medium.jpg") 
    end

end
