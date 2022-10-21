# frozen_string_literal: true

FactoryBot.define do
  factory :best_answer do
    association :teacher
    association :student
    association :question
  end
end
