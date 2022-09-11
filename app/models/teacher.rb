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
end
