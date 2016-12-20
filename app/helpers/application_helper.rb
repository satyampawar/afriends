module ApplicationHelper
	def post_photo(user_id,photo)
      image_tag("https://googledrive.com/host/0B3-wKP83_thWanZaVlJSUGxYLW8/original_"+user_id.to_s+"_"+photo)
    # image_tag("https://googledrive.com/host/0B3-wKP83_thWanZaVlJSUGxYLW8/medium_22_PicsArt_1433932787086_medium.jpg") 
   end
   
  def user_picture(user,id=nil,class_name=nil,set_width=nil)  
    if user.avatar.present? 
      image_tag(user.avatar.url ,id: id,class: class_name, width: set_width) 
    elsif user.img_url.present? 
      image_tag(user.img_url ,id: id,class: class_name, width: set_width) 
    else
      image_tag('/assets/user.png' ,id: id,class: class_name, width: set_width) 
    end
  end
end
