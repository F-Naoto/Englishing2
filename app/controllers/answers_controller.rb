# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_teacher!

  def create
    @answer = current_teacher.answers.build(answer_params)
    existing_answer_combination = Answer.where(teacher_id: current_teacher.id).where(question_id: params[:answer][:question_id])

    if existing_answer_combination.empty? && @answer.save
      flash[:success] = '回答を投稿しました。'
    else
      flash[:danger] = '回答に失敗しました。'
    end
    redirect_to "/questions/#{params[:answer][:question_id]}"
  end

  # def edit
  #   @answer = Answer.find(params[:id])
  # end

  # def update
  #   @answer = Answer.find(params[:id])
  #   @answer.update(answer_params)
  #   redirect_to question_path(@answer.question_id)
  # end

  # def destroy
  #   @answer = Answer.find(params[:id])
  #   question = @answer.question
  #   @answer.destroy
  #   flash[:success] = '回答を削除しました。'
  #   redirect_to question_path(question)
  # end

  private

  def answer_params
    params.require(:answer).permit(:content, :question_id)
  end
end
