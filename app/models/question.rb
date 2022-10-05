# frozen_string_literal: true

class Question < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :student
  has_many   :answers, dependent: :destroy
  has_many   :likes, dependent: :destroy
  has_many   :best_answers, dependent: :destroy
  has_many   :ss_notifications, dependent: :destroy
  with_options presence: true do
    validates  :title, length: { minimum: 1, maximum: 20 }
    validates  :content, length: { minimum: 1, maximum: 200 }
    validates  :student_id
  end

  def liked_by?(student)
    likes.exists?(student_id: student.id)
  end

  def create_notification_by(current_student)
    ss_notification = current_student.ss_active_notifications.build(
      question_id: id,
      visited_id: student_id,
      action: 'like'
    )
    ss_notification.save if ss_notification.valid?
  end
end
