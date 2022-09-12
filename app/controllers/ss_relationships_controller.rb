class SsRelationshipsController < ApplicationController
  def create
    current_student.ss_follow(params[:followed_id])
    followed_student = Student.find(params[:followed_id])
    followed_student.create_notification_follow!(current_student)
    redirect_to request.referer
  end

  def destroy
    current_student.ss_unfollow(params[:followed_id]).destroy
    redirect_to request.referer
  end
end
