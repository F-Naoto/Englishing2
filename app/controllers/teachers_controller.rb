# frozen_string_literal: true

class TeachersController < ApplicationController
  before_action :set_teacher, only: %i[show st_follower]
  before_action :check_id, only: %i[chat_member]

  def index
    @search = Teacher.ransack(params[:q])
    @teachers = @search.result.page(params[:page]).per(8)
  end

  def show
    @teacher_review = current_student.teacher_reviews.build if current_student
  end

  def chat_member
    @teacher = Teacher.find(params[:id])
    @chat_members = current_teacher.chat_room_users if current_teacher && !current_teacher.chat_room_users.nil?
  end

  def st_follower
    @st_followers = @teacher.st_followers
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  def check_id
    @teacher = Teacher.find(params[:id])
    unless current_teacher.id == @teacher.id
      redirect_to root_url
      flash[:alert] = '不正な操作が行われました。'
    end
  end
end
