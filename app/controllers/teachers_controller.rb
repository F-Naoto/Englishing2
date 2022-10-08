class TeachersController < ApplicationController
  before_action :set_teacher, only: %i[show st_follower]

  def index
    @search = Teacher.ransack(params[:q])
    @teachers = @search.result.page(params[:page]).per(8)
  end

  def show
    @teacher_review = current_student.teacher_reviews.build if current_student
  end

  def st_follower
    @st_followers = @teacher.st_followers
  end

  private
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end
end
