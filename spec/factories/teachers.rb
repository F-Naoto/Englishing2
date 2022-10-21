# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    sequence(:name) { |n| "teacher#{n}" }
    sequence(:email) { |n| "teacher#{n}@example.com" }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
