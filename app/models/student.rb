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
  has_many :st_active_relationships, class_name: "StRelationship",
                                     foreign_key: "follower_id",
                                     dependent: :destroy
  has_many :st_following, through: :st_active_relationships, source: :followed
  has_many :ss_active_relationships, class_name: "SsRelationship",
                                     foreign_key: "follower_id",
                                     dependent: :destroy
  has_many :ss_following, through: :ss_active_relationships, source: :followed
  has_many :ss_passive_relationships, class_name: "SsRelationship",
                                      foreign_key: "followed_id",
                                      dependent: :destroy
  has_many :ss_follower, through: :ss_passive_relationships, source: :follower
  has_many :best_answers, dependent: :destroy
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users
  has_many :chat_messages, dependent: :destroy
  has_many :ss_active_notifications,  class_name: 'SsNotification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :ss_passive_notifications, class_name: 'SsNotification', foreign_key: 'visited_id', dependent: :destroy

    def st_follow(teacher)
      st_active_relationships.create(followed_id: teacher)
    end

    def st_unfollow(teacher)
      st_active_relationships.find_by(followed_id: teacher)
    end

    def st_following?(teacher)
      st_following.include?(teacher)
    end

    def ss_follow(student)
      ss_active_relationships.create(followed_id: student)
    end

    def ss_unfollow(student)
      ss_active_relationships.find_by(followed_id: student)
    end

    def ss_following?(student)
      ss_following.include?(student)
    end

    def create_notification_follow!(current_student)
      temp = SsNotification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_student.id, id, 'follow'])
      if temp.blank?
        ss_notification = current_student.ss_active_notifications.build(
          visited_id: id,
          action: 'follow'
        )
        ss_notification.save if ss_notification.valid?
      end
    end
end
