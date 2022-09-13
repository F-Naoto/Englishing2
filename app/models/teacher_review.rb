class TeacherReview < ApplicationRecord
  belongs_to :student
  belongs_to :teacher

  validates :content, presence: true
  validates :score, presence: true
end
