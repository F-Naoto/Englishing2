class LikesController < ApplicationController
  before_action :authenticate_student!

  def create
    like = current_student.likes.build(question_id: params[:question_id])
    @question = Question.find(params[:question_id])
    @question.create_notification_by(current_student) if like.save
  end

  def destroy
    @question = Question.find(params[:question_id])
    like = current_student.likes.find_by(question_id: params[:question_id])
    like.destroy
  end
end
