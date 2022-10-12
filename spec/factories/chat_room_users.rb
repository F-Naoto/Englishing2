FactoryBot.define do
  factory :chat_room_user do
    association :chat_room
    association :student
    association :teacher
  end
end
