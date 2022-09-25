module SsNotificationsHelper
  def ss_notification_form(ss_notification)
	  @visitor = ss_notification.visitor
	  case ss_notification.action
	    when "follow" then
	      tag.a(ss_notification.visitor.name, href:student_path(@visitor), style:"font-weight: bold;")+
				"があなたをフォローしました。"
	    when "like" then
	      tag.a(ss_notification.visitor.name, href:student_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの質問', href:question_path(ss_notification.question_id), style:"font-weight: bold;")+"にいいねしました。"
	  end
  end

  def unchecked_ss_notifications
    @ss_notifications = current_student.ss_passive_notifications.where(checked: false)
  end
end
