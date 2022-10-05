class SsRelationship < ApplicationRecord
  belongs_to :follower, class_name:"Student"
  belongs_to :followed, class_name:"Student"
  with_options presence: true do
    validates  :follower_id
    validates  :followed_id
  end
end
