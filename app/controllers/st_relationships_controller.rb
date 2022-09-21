class StRelationshipsController < ApplicationController
  def create
    @followed_teacher = Teacher.find(params[:followed_id])
    current_student.st_follow(params[:followed_id])
  end

  def destroy
    @followed_teacher = Teacher.find(params[:followed_id])
    current_student.st_unfollow(params[:followed_id]).destroy
  end
end
