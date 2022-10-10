class StudentsController < ApplicationController
  before_action :set_student, only: %i[show  chat_member st_following ss_following ss_follower]
  before_action :check_id, only: %i[chat_member]

  def index
    @search = Student.ransack(params[:q])
    @students = @search.result.page(params[:page]).per(8)
  end

  def show
  end

  def chat_member
    if current_student && !current_student.chat_room_users.nil?
      @chat_members = current_student.chat_room_users
    end
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

  def check_id
    unless current_student.id == @student.id
      redirect_to root_url
      flash[:alert] = "不正な操作が行われました。"
    end
  end
end
