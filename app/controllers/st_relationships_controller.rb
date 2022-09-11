class StRelationshipsController < ApplicationController
  def create
    current_student.st_follow(params[:followed_id])
    redirect_to request.referer
  end

  def destroy
    current_student.st_unfollow(params[:followed_id]).destroy
    redirect_to request.referer
  end
end
