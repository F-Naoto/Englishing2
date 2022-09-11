class SsRelationshipsController < ApplicationController
  def create
    current_student.ss_follow(params[:followed_id])
    redirect_to request.referer
  end

  def destroy
    current_student.ss_unfollow(params[:followed_id]).destroy
    redirect_to request.referer
  end
end
