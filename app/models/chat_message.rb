class ChatMessage < ApplicationRecord
  after_create_commit { ChatMessageBroadcastJob.perform_later self }

  belongs_to :teacher
  belongs_to :student
  belongs_to :chat_room
end
