# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :student
  belongs_to :question
  with_options presence: true do
    validates  :student_id
    validates  :question_id
  end
end
