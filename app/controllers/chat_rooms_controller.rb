class ChatRoomsController < ApplicationController
  before_action :authenticate_any!
  before_action :check_authenticate_user, only:%i[show]

  def create
    chat_room_user = ChatRoomUser.where(student_id: current_student.id).where(teacher_id: params[:teacher_id])
    if chat_room_user.blank?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room_id: chat_room.id, student_id: current_student.id, teacher_id: params[:teacher_id])
      redirect_to chat_room_path(chat_room)
    else
      redirect_to chat_room_path(chat_room_user.map(&:chat_room_id))
    end
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @chat_messages = ChatMessage.where(chat_room: @chat_room).limit(15)
    @student_id = @chat_room.chat_room_users.map(&:student_id).first
    @teacher_id = @chat_room.chat_room_users.map(&:teacher_id).first
    @student = Student.find(@student_id)
    @teacher = Teacher.find(@teacher_id)
  end

  def authenticate_any!
    if current_student || current_teacher
      true
    else
      flash[:alert] = '先生もしくは生徒でログインをしてください。'
      redirect_to root_url
    end
  end

  def check_authenticate_user
    @chat_room = ChatRoom.find(params[:id])
    if current_student
      unless @chat_room.chat_room_users.map(&:student_id) == [current_student.id]
        redirect_to root_url
        flash[:alert] = "不正な操作が行われました。"
      end
    end
    if current_teacher
      unless  @chat_room.chat_room_users.map(&:teacher_id) == [current_teacher.id]
        redirect_to root_url
        flash[:alert] = "不正な操作が行われました。"
      end
    end
  end
end
