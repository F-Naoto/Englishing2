FactoryBot.define do
  factory :best_answer do
    association :teacher
    association :student
    association :question
  end
end
