class Answer < ApplicationRecord
  default_scope->{order(created_at: :desc)}

  belongs_to :teacher
  belongs_to :question
  has_many   :best_answers, dependent: :destroy
  validates  :content, presence: true, length: {minimum:1, maximum:300}
end
