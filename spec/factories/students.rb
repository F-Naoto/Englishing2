FactoryBot.define do
  factory :student do
    sequence(:name) { |n| "student#{n}" }
    sequence(:email) { |n| "student#{n}@example.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end
