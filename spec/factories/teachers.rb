FactoryBot.define do
  factory :teacher do
    name { "teacher" }
    email { "teacher@email.com" }
    password { "12345678" }
    password_confirmation { "12345678" }
  end
end
