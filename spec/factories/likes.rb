# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :student
    association :question
  end
end
