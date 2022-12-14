# frozen_string_literal: true

class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed; end

  def speak(data)
    ChatMessage.create!(
      content: data['chat_message'],
      chat_room_id: data['room_id'],
      teacher_id: data['teacher_id'],
      student_id: data['student_id'],
      poster: data['poster']
    )
  end
end
