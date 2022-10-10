FactoryBot.define do
  factory :student do
    name { "student" }
    email { "student@email.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end
