module NotificationsHelper
	def notification_tag_helper(notific)
		html = ""
		html = "<div class= #{notific.is_read ? 'ntf-read': 'ntf-not-read'}>
				<p><img src='/assets/wall_post.png' width='16px'><b> #{User.find(notific.notifier_id).fullname}</b><span> is tagged you in it's post</span></p>
		</div>"
		return html.html_safe
	end
end
