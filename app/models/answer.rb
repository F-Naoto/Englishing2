class Answer < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :teacher
  belongs_to :question
  with_options presence: true do
    validates  :content, length: { minimum: 1, maximum: 300 }
    validates  :teacher_id
    validates  :question_id
  end
end
