# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    content { '回答テスト' }
    association :teacher
    association :question
  end
end
