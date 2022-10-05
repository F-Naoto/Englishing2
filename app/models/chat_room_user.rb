class ChatRoomUser < ApplicationRecord
  belongs_to :teacher
  belongs_to :student
  with_options presence: true do
    validates  :chat_room_id
    validates  :teacher_id
    validates  :student_id
  end
end
