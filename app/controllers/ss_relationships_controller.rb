class SsRelationshipsController < ApplicationController
  def create
    current_student.ss_follow(params[:followed_id])
    @followed_student = Student.find(params[:followed_id])
    @followed_student.create_notification_follow!(current_student)
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
    # redirect_to request.referer
  end

  def destroy
    @followed_student = Student.find(params[:followed_id])
    current_student.ss_unfollow(params[:followed_id]).destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
    # redirect_to request.referer
  end
end
