class SsRelationshipsController < ApplicationController
  def create
    current_student.ss_follow(params[:followed_id])
    @followed_student = Student.find(params[:followed_id])
    @followed_student.create_notification_follow!(current_student)
  end

  def destroy
    @followed_student = Student.find(params[:followed_id])
    current_student.ss_unfollow(params[:followed_id]).destroy
  end
end
