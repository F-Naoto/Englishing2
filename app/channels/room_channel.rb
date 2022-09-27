class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'room_channel', { content: data['content']}
    # ChatMessage.create!(content:      data['content'])
                        # chat_room_id: params['chat_room'],
                        # teacher_id:   params['chat_room'],
                        # student_id:   current_student.id)
  end
end
