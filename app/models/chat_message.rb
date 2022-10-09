class ChatMessage < ApplicationRecord
  after_create_commit { ChatMessageBroadcastJob.perform_later self }

  belongs_to :teacher
  belongs_to :student
  belongs_to :chat_room
  with_options presence: true do
    validates  :chat_room_id
    validates  :teacher_id
    validates  :student_id
    validates  :content
  end
end
