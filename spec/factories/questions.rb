# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { 'タイトルテスト' }
    content { '質問テスト' }
    association :student
  end
end
