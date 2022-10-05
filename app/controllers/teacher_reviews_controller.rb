class TeacherReviewsController < ApplicationController
  before_action :authenticate_student!, only: [:create]
  after_action  :change_average_score,  only: [:create]

  def index
    @teacher = Teacher.find(params[:teacher_id])
  end

  def create
    @teacher_review = current_student.teacher_reviews.build(teacher_review_params)
    if @teacher_review.save
      flash[:notice] = "レビューを投稿しました。"
      redirect_to teacher_teacher_reviews_path(@teacher_review.teacher)
    else
      @teacher = @teacher_review.teacher
      flash.now[:alert] = "レビューを投稿できませんでした。"
      render "teachers/show"
    end
  end

  def change_average_score
    @teacher = Teacher.find(teacher_review_params[:teacher_id])
    average_score = @teacher.average_score
    @teacher.update(average_score: average_score)
  end

  #   def destroy
  #     Teacher.find(params[:id]).destroy
  #     flash[:success] = "User deleted"
  #     redirect_to teachers_url
  #   end

  def ranking
    @teachers = Teacher.order(average_score: :DESC).limit(10)
  end

  private
    def teacher_review_params
      params.require(:teacher_review).permit(:teacher_id, :score, :content)
    end
end
