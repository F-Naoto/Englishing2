class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_messages, dependent: :destroy
  has_many :students, through: :chat_room_users
  has_many :teachers, through: :chat_room_users
end
