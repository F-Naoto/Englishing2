class StudentsController < ApplicationController
  before_action :authenticate_student!

  def index
    @search = Student.ransack(params[:q])
    @students = @search.result.page(params[:page]).per(5)
  end

  def show
    @student = Student.find(params[:id])
  end
end
