class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :teacher_reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :best_answers, dependent: :destroy
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_messages, dependent: :destroy
    # ユーザーをフォローする
    def follow(other_user)
      active_relationships.create(followed_id: other_user)
    end

    # ユーザーのフォローを外す
    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user)
    end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
