class TeachersController < ApplicationController
  def index
    @search = Teacher.ransack(params[:q])
    @teachers = @search.result.page(params[:page]).per(5)
  end

  def show
    @teacher = Teacher.find(params[:id])
    @teacher_review = current_student.teacher_reviews.build if current_student
    @teacher_reviews = TeacherReview.all
  end
end
