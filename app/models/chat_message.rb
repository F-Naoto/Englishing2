class ChatMessage < ApplicationRecord
  belongs_to :teacher
  belongs_to :student
  belongs_to :chat_room
end
