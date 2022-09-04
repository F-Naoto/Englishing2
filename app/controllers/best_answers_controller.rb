class BestAnswersController < ApplicationController
  def create
    @best_answer = current_student.best_answers.build(best_answer_params)
    question = Question.find(params[:best_answer][:question_id])
    if @best_answer.save
      flash[:success] = "ベストアンサーを選びました。"
      redirect_to question
    else
      flash[:danger] = "失敗しました。"
      render :index
    end
  end

    private
    def best_answer_params
      params.require(:best_answer).permit(:question_id, :teacher_id)
    end
end
