class TeacherReview < ApplicationRecord
  default_scope->{order(created_at: :desc)}

  belongs_to :student
  belongs_to :teacher

  validates :content, presence: true
  validates :score,   presence: true
end
