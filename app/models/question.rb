class Question < ApplicationRecord
  default_scope->{order(created_at: :desc)}

  belongs_to :student
  has_many   :answers, dependent: :destroy
  has_many   :likes, dependent: :destroy
  has_many   :best_answers, dependent: :destroy

  def liked_by?(student)
    likes.exists?(student_id: student.id)
  end
end
