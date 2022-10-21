# frozen_string_literal: true

FactoryBot.define do
  factory :teacher_review do
    association :student
    association :teacher
    score { 3 }
    content { 'レビューテスト' }
  end
end
