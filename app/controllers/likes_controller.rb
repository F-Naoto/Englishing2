class LikesController < ApplicationController
  def create
    like = current_student.likes.build(question_id: params[:question_id])
    if like.save
    redirect_to question_path(params[:question_id])
    end
  end

  def destroy
    like = current_student.likes.find_by(question_id: params[:question_id])
    like.destroy
    redirect_to question_path(params[:question_id])
  end
end