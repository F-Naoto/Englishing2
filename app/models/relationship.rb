class Relationship < ApplicationRecord
  belongs_to :follower, class_name:"Student"
  belongs_to :followed, class_name:"Teacher"
end
