# frozen_string_literal: true

class TeachersController < ApplicationController
  def index
    @search = Teacher.ransack(params[:q])
    @teachers = @search.result.page(params[:page]).per(8)
  end

  def show
    @teacher = Teacher.find(params[:id])
    @teacher_review = current_student.teacher_reviews.build if current_student
  end
end
