class TeacherReviewsController < ApplicationController
  before_action :authenticate_student!, only: %i[create]

  def index
    @teacher = Teacher.find(params[:teacher_id])
  end

  def create
    @teacher = Teacher.find(teacher_review_params[:teacher_id])
    @teacher_review = current_student.teacher_reviews.build(teacher_review_params)
    if @teacher_review.save
      update_average_score
      flash[:notice] = "レビューを投稿しました。"
      redirect_to teacher_teacher_reviews_path(@teacher_review.teacher)
    else
      teacher = @teacher_review.teacher
      flash.now[:alert] = "レビューを投稿できませんでした。"
      redirect_to teacher_path(teacher.id)
    end
  end

  def update_average_score
    average_score = @teacher.average_review_score
    @teacher.update_attribute(:average_score, average_score)
  end

  def ranking
    @teachers = Teacher.order(average_score: "DESC").limit(5)
  end

  private
  def teacher_review_params
    params.require(:teacher_review).permit(:teacher_id, :score, :content)
  end
end
