require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  let!(:student) { create(:student) }
  let!(:other_student) { create(:student) }
  let!(:question) { create(:question, student_id: student.id) }

  before do
    login_as student, scope: :student
    visit ss_notifications_path
  end

  describe 'ページ遷移' do
    context '生徒の通知ページに遷移' do
      it '生徒の通知ページへのアクセスに成功' do
        expect(page).to have_content '通知'
      end
    end
  end

  describe '通知' do
    context '通知がない場合' do
      it '通知はありませんと表示される' do
        expect(page).to have_content "通知はありません..."
      end
    end
    context '質問にいいねされた場合' do
      it 'いいねの通知が表示される' do
        other_student.ss_active_notifications.create(question_id: question.id,
                                                     visited_id: student.id,
                                                     action: 'like')
        visit ss_notifications_path
        expect(page).to have_content "#{other_student.name}があなたの質問にいいねしました。"
      end
    end
    context 'フォローされた場合' do
      it 'フォローの通知が表示される' do
        other_student.ss_active_notifications.create(
          visited_id: student.id,
          action: 'follow')
          visit ss_notifications_path
          expect(page).to have_content "#{other_student.name}があなたをフォローしました。"
      end
    end
  end
end
