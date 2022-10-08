# frozen_string_literal: true

class StRelationship < ApplicationRecord
  belongs_to :follower, class_name: 'Student'
  belongs_to :followed, class_name: 'Teacher'
  with_options presence: true do
    validates  :follower_id
    validates  :followed_id
  end
end
