class ChatRoomsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :authenticate_student!

  def create
    chat_room_user = ChatRoomUser.where(student_id: current_student.id).where(teacher_id: params[:teacher_id])
    if chat_room_user.blank?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room_id: chat_room.id, student_id: current_student.id, teacher_id: params[:teacher_id])
      flash[:alert] = "hogehoge"
      redirect_to chat_room_path(chat_room)
    else
      redirect_to chat_room_path(chat_room_user.map(&:chat_room_id))
    end
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    # @chat_room_user = @chat_room.chat_room_users.where.not(student_id: current_student.id).first.student
    @chat_messages = ChatMessage.where(chat_room: @chat_room)
  end
end
