class StudentsController < ApplicationController
  before_action :set_student, only: %i[show st_following ss_following ss_follower]

  def index
    @search = Student.ransack(params[:q])
    @students = @search.result.page(params[:page]).per(8)
  end

  def show
  end

  def st_following
    @st_followings = @student.st_following
  end

  def ss_following
    @ss_followings = @student.ss_following
  end

  def ss_follower
    @ss_followers = @student.ss_follower
  end

  private
  def set_student
    @student = Student.find(params[:id])
  end
end
