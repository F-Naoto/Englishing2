module SsNotificationsHelper
  def ss_notification_form(ss_notification)
	  @visitor = ss_notification.visitor
	  # your_item = link_to 'あなたの投稿', users_item_path(notification), style:"font-weight: bold;"
	  case ss_notification.action
	    when "follow" then
	      # tag.a(ss_notification.visitor.name, href:users_user_path(@visitor), style:"font-weight: bold;")+
				"があなたをフォローしました"
	    when "like" then
	      # tag.a(ss_notification.visitor.name, href:users_user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_item_path(notification.item_id), style:"font-weight: bold;")+"
        "にいいねしました"
	  end
  end

  def unchecked_ss_notifications
    @notifications = current_student.ss_passive_notifications.where(checked: false)
  end
end
