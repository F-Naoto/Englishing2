# frozen_string_literal: true

FactoryBot.define do
  factory :ss_notification do
    title { 'タイトルテスト' }
    content { '質問テスト' }
    association :student
  end
end
