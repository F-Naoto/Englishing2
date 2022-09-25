class SsNotificationsController < ApplicationController
  def index
    @ss_notifications = current_student.ss_passive_notifications.page(params[:page]).per(20)
    @ss_notifications.where(checked: false).each do |ss_notification|
        ss_notification.update_attributes(checked: true)
    end
  end
end
