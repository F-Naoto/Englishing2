class AnswersController < ApplicationController
  before_action :authenticate_teacher!
  def create
    @answer = current_teacher.answers.build(question_params)
    if @answer.save
      flash[:success] = "質問を投稿しました。"
      redirect_to "/questions/#{params[:answer][:question_id]}"
    else
      flash[:danger] = "質問を投稿できませんでした。"
      render 
    end
  end

  private
    def question_params
      params.require(:answer).permit(:content, :question_id)
    end
end
