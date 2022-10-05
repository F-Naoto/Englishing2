class BestAnswer < ApplicationRecord
  belongs_to :student
  belongs_to :teacher
  belongs_to :question
  with_options presence: true do
    validates  :question_id
    validates  :teacher_id
    validates  :student_id
  end
end
