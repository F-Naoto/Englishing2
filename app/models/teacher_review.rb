# frozen_string_literal: true

class TeacherReview < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :student
  belongs_to :teacher
  with_options presence: true do
    validates  :student_id
    validates  :teacher_id
    validates  :content
    validates  :score
  end
end
