class TeacherReview < ApplicationRecord
  belongs_to :student
  belongs_to :teacher

  validates :content, presence: true
  validates :score, presence: true

  def score_display(teacher_review)
    case teacher_review.score
    when teacher_review.score == 1
      "★"
    when teacher_review.score == 2
      "★★"
    when teacher_review.score == 3
      "★★★"
    when teacher_review.score == 4
      "★★★★"
    else
      "★★★★★"
    end
  end
end
