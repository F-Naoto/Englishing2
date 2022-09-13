class TeacherReviewsController < ApplicationController
  before_action :authenticate_student!, only: [:create]
  def index
    @teacher = Teacher.find(params[:teacher_id])
  end

  def create
    @teacher_review = current_student.teacher_reviews.build(teacher_review_params)
    if @teacher_review.save
      flash[:notice] = "レビューを投稿しました。"
      redirect_to teacher_teacher_reviews_path(@teacher_review.teacher)
    else
      flash[:alert] = "レビューを投稿できませんでした。"
      #保留
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @teacher
    else
      render 'edit'
    end
  end

  #   def destroy
  #     Teacher.find(params[:id]).destroy
  #     flash[:success] = "User deleted"
  #     redirect_to teachers_url
  #   end

  private
    def teacher_review_params
      params.require(:teacher_review).permit(:teacher_id, :score, :content)
    end
end
