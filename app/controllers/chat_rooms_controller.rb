class ChatRoomsController < ApplicationController
  before_action :authenticate_teacher!
  before_action :authenticate_student!

  def create
    current_student_chat_rooms = ChatRoomUser.where(student_id: current_student.id).map(&:chat_room_id)
    chat_room = ChatRoomUser.where(chat_room_id: current_student_chat_rooms, teacher_id: params[:teacher_id]).map(&:chat_room_id).first
    if chat_room.blank?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room_id: chat_room.id, student_id: current_student.id, teacher_id: params[:teacher_id])
    end
    redirect_to chat_room_path(chat_room)
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    # @chat_room_user = @chat_room.chat_room_users.where.not(student_id: current_student.id).first.student
    @chat_messages = ChatMessage.where(chat_room: @chat_room)
  end
end
