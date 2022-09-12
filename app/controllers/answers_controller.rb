class AnswersController < ApplicationController
  before_action :authenticate_teacher!
  def create
    @answer = current_teacher.answers.build(question_params)
    existing_answer_combination = Answer.where(teacher_id: current_teacher.id).where(question_id: params[:answer][:question_id])

    if existing_answer_combination.empty? && @answer.save
      flash[:success] = "回答を投稿しました。"
      redirect_to "/questions/#{params[:answer][:question_id]}"
    else
      flash[:danger] = "回答は一回までです。"
      render "/questions/#{params[:answer][:question_id]}"
    end
  end

  private
    def question_params
      params.require(:answer).permit(:content, :question_id)
    end
end
