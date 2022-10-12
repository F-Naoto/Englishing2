FactoryBot.define do
  factory :like do
    association :student
    association :question
  end
end
