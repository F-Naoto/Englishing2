require 'rails_helper'

RSpec.describe SsNotification, type: :model do
  let(:student) { create(:student) }
  let(:other_student) { create(:student) }
  let(:question) { create(:question) }
  it "通知を正常に登録できる" do
    notification = create(:ss_notification, visitor_id: student.id, visited_id: other_student.id)
    expect(notification).to be_valid
  end
  it "いいねの通知を正常に登録できる" do
    like_notification = student.ss_active_notifications.build(
      question_id: question.id,
      visited_id: other_student.id,
      action: 'like'
    )
    expect(like_notification).to be_valid
  end
  it "フォローの通知を正常に登録できる" do
    follow_notification = student.ss_active_notifications.build(
      visited_id: other_student.id,
      action: 'follow'
    )
    expect(follow_notification).to be_valid
  end
end
#   validates  :question_id
#   validates  :action
#   validates  :checked
# ss_notification = current_student.ss_active_notifications.build(
#   visited_id: id,
#   action: 'follow'
# )
# ss_notification.save if ss_notification.valid?
# def create_notification_by(current_student)
#   ss_notification = current_student.ss_active_notifications.build(
#     question_id: id,
#     visited_id: student_id,
#     action: 'like'
#   )
#   ss_notification.save if ss_notification.valid?
# end
