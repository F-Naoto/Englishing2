class BestAnswer < ApplicationRecord
  belongs_to :student
  belongs_to :teacher
  belongs_to :question

  def best_answer_selected?(question)
    exists?(question_id: question.id)
  end
end
