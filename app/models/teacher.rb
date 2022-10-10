# frozen_string_literal: true

class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :answers, dependent: :destroy
  has_many :teacher_reviews, dependent: :destroy
  has_many :st_passive_relationships, class_name: 'StRelationship',
                                      foreign_key: 'followed_id',
                                      dependent: :destroy
  has_many :st_followers, through: :st_passive_relationships, source: :follower
  has_many :best_answers, dependent: :destroy
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_messages, dependent: :destroy
  validates :name, presence: true, length: { minimum: 2, maximum: 10 }, uniqueness: true
  validates :self_introduction, length: { maximum: 100 }

  def average_review_score
    if teacher_reviews.empty?
      0.0
    else
      teacher_reviews.average(:score).round(1).to_f
    end
  end

  def review_score_percentage
    if teacher_reviews.empty?
      0.0
    else
      average = teacher_reviews.average(:score).to_f * 100 / 5
      average.round(1)
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest_teacher@example.com') do |teacher|
      password = SecureRandom.urlsafe_base64(10)
      teacher.password = password
      teacher.password_confirmation = password
      teacher.name = 'GuestTeacher'
    end
  end
end
