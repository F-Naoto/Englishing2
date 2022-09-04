class RelationshipsController < ApplicationController
  def create
    current_student.follow(params[:followed_id])
    redirect_to request.referer
  end

  def destroy
    current_student.unfollow(params[:followed_id]).destroy
    redirect_to request.referer
  end
end
