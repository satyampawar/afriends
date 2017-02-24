module NotificationsHelper
	def notification_tag_helper(notific)
		html = ""
		html += "<div class= #{notific.is_read ? 'ntf-read': 'ntf-not-read'}>
				<p><img src='/assets/wall_post.png' width='16px'><b> #{User.find(notific.notifier_id).fullname}</b><span> is tagged you in"
    if notific.extra_data[:userid] == notific.notifier_id
			html +=	" it's post"
		else
      html +=	"#{User.find(notific.extra_data[:userid]).fullname}'s post"
		end
		html += "</span></p></div>"
		return html.html_safe
	end


	def notification_like_helper(notific)
		like = Like.find(notific.extra_data[:likeid])
		html = ""
		html += "<div class= #{notific.is_read ? 'ntf-read': 'ntf-not-read'}>
				<p><img src='/assets/reaction-img/reactions_#{like.emotion}.png' width='16px'><b> #{User.find(notific.notifier_id).fullname}</b><span> liked "
    if like.post.user.id == notific.user_id
			html +=	" your post"
		else
      html +=	"#{User.find(like.post.user.id).fullname}'s post"
		end
		html += ", where you have tagged</span></p></div>"
		return html.html_safe
	end

	def notification_birthday_helper(notific)
		html = ""
		html += "<div class= #{notific.is_read ? 'ntf-read': 'ntf-not-read'}>
				<p><img src='/assets/reaction-img/reactions_#{like.emotion}.png' width='16px'><b> Today is birthday of #{User.find(notific.notifier_id).fullname}</b><span>"
		return html.html_safe
	end
end
