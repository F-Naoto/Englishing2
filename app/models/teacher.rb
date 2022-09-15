class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :answers, dependent: :destroy
  has_many :teacher_reviews, dependent: :destroy
  has_many :st_passive_relationships, class_name: "StRelationship",
                                      foreign_key: "followed_id",
                                      dependent: :destroy
  has_many :st_followers, through: :st_passive_relationships, source: :follower
  has_many :best_answers, dependent: :destroy
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_messages, dependent: :destroy

  def average_score
    unless self.teacher_reviews.empty?
      teacher_reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless self.teacher_reviews.empty?
      average = teacher_reviews.average(:score).to_f*100/5
      average.round(1)
    else
      0.0
    end
  end
end
