class SsNotification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :question, optional: true
  belongs_to :visitor, class_name: 'Student', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'Student', foreign_key: 'visited_id', optional: true
end
