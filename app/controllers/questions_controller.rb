class QuestionsController < ApplicationController
  # before_action :authenticate_student!

  def index
    @questions = Question.page(params[:page]).per(5)
  end

  def show
    @question = Question.find(params[:id])
    @likes = @question.likes
    @answer = current_teacher.answers.build if current_teacher
    @best_answer = current_student.best_answers.build if current_student
  end

  def new
    @question = current_student.questions.build
  end

  def create
    @question = current_student.questions.build(question_params)
    if @question.save
      flash[:success] = "質問を投稿しました。"
      redirect_to questions_path
    else
      flash[:danger] = "質問を投稿できませんでした。"
      render :index
    end
  end

    private
      def question_params
        params.permit(:title, :content)
      end
end
