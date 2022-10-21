# frozen_string_literal: true

FactoryBot.define do
  factory :chat_message do
    content { 'テストチャットメッセージ' }
    poster { 'true' }
    association :teacher
    association :student
    association :chat_room
  end
end
