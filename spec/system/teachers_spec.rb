require 'rails_helper'
require 'devise'

RSpec.describe "Teachers", type: :system do
  let!(:teacher) { create(:teacher, name: "teacher", self_introduction: "introduction", average_score:3) }
  let(:other_teacher) { create(:teacher)}
  let(:student) { create(:student)}
  describe 'ページ遷移確認' do
    before do
      visit teachers_path
    end
    context '先生の一覧ページに遷移' do
      it '先生の一覧ページへのアクセスに成功' do
        teacher_list = create_list(:teacher, 3)
        visit teachers_path
        expect(page).to have_content 'Meet Your Teachers'
        expect(page).to have_content teacher_list[0].name
        expect(page).to have_content teacher_list[1].name
        expect(page).to have_content teacher_list[2].name
        expect(current_path).to eq teachers_path
      end
      # it '先生の画像が表示される' do
      #   teacher_list = create_list(:teacher, 3)
      #   expect(page).to have_content 'Meet Your Friends'
      #   expect(page).to have_content teacher_list[0].name
      #   expect(page).to have_content teacher_list[1].name
      #   expect(page).to have_content teacher_list[2].name
      #   expect(current_path).to eq teachers_path
      # end
      it 'キーワードを入力して検索した場合、先生名、自己紹介、平均点が表示される' do
        fill_in 'キーワードを入力', with: "introduction"
        click_button '検索'
        expect(page).to have_content "#{teacher.self_introduction}"
        expect(page).to have_content "#{teacher.name}"
        expect(page).to have_content "#{teacher.average_score}"
      end
      it 'キーワードを入力して検索した場合、先生詳細ページへのリンクが正常に機能する' do
        fill_in 'キーワードを入力', with: "introduction"
        click_button '検索'
        expect(page).to have_link "#{teacher.name}", href: teacher_path(teacher.id)
      end
      it '先生名を入力して検索できる' do
        fill_in '先生名を入力', with: "#{teacher.name}"
        click_button '検索'
        expect(page).to have_link "#{teacher.name}"
      end
    end
    # context '先生の新規作成ページに遷移' do
    #   it '先生の新規作成ページへのアクセスに成功' do
    #     visit new_teacher_session_path
    #     expect(page).to have_content 'Meet Your Friends'
    #     expect(page).to have_content 'Meet Your Friends'
    #     expect(page).to have_content '先生新規作成'
    #     expect(current_path).to eq new_teacher_path
    #   end
    # end
    context '先生の編集ページに遷移' do
      before do
        login_as teacher, scope: :teacher
        visit edit_teacher_registration_path(teacher)
      end
      it '先生の編集ページへのアクセスに成功' do
        expect(page).to have_content '先生アカウント情報編集'
        expect(page).to have_field 'teacher[name]', with: teacher.name
        expect(page).to have_field 'teacher[email]', with: teacher.email
        expect(page).to have_field 'teacher[self_introduction]', with: teacher.self_introduction
        expect(current_path).to eq edit_teacher_registration_path(teacher)
      end
      it 'ユーザー名の編集に成功' do
        fill_in 'teacher[name]', with: "#{teacher.name}"
        fill_in 'teacher[current_password]', with: "#{teacher.password}"
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq teacher_path(teacher)
      end
      it 'メールアドレスの編集に成功' do
        fill_in 'teacher[email]', with: "change_email@gmail.com"
        fill_in 'teacher[current_password]', with: "#{teacher.password}"
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq teacher_path(teacher)
      end
      it 'パスワードの編集に成功' do
        fill_in 'teacher[password]', with: "new_password"
        fill_in 'teacher[password_confirmation]', with: 'new_password'
        fill_in 'teacher[current_password]', with: "#{teacher.password}"
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq teacher_path(teacher)
      end
      it '編集に失敗' do
        fill_in 'teacher[email]', with: "change_email@gmail.com"
        click_button '変更する'
        expect(page).to have_content '現在のパスワードを入力してください'
        expect(current_path).to eq teachers_path
      end
    end

    context '先生の詳細ページに遷移' do
      before do
        login_as student, scope: :student
        visit teacher_path(teacher)
      end
      it '先生の詳細ページへのアクセスに成功' do
        expect(current_path).to eq teacher_path(teacher)
      end
      it '先生の詳細ページの内容が正しく表示できる' do
        expect(page).to have_content 'Teacher Profile'
        expect(page).to have_content teacher.name
        expect(page).to have_content '回答数'
        expect(page).to have_content "評価"
        expect(page).to have_content 'フォロワー（生徒）'
        expect(page).to have_content 'レビューはまだありません。'
        expect(page).to have_link 'Message'
        expect(page).to have_button 'Follow'
      end
    end

    # context 'メッセージのページに遷移' do
    #   let!(:review) { create(:teacher_review, teacher_id: other_teacher.id)}
    #   let!(:chat_room) { create(:chat_room, id:1) }
    #   let!(:chat_room_user) { create(:chat_room_user, chat_room_id: chat_room.id, student_id: student.id, teacher_id: teacher.id)}
    #   before do
    #     login_as student, scope: :student
    #     visit teacher_path(teacher)
    #     click_link 'Message'
    #   end
    #   it '先生のメッセージページへのアクセスに成功' do
    #     expect(current_path).to eq chat_room_path(chat_room)
    #   end
    #   it '先生のメッセージページの内容が正しく表示できる' do
    #     expect(page).to have_content teacher.name
    #     expect(page).to have_content ''
    #     expect(page).to have_content ''
    #   end
    #   it 'メッセージを送信できる' do

    #   end

      # it 'ユーザーをフォロー、フォロー解除できる' do
      #   login_as teacher, scope: :teacher
      #   visit teacher_path(other_teacher)
      #   expect {
      #     click_on 'Follow'
      #     sleep 0.5
      #   }.to change { SsRelationship.count }.by(1)
      # end
    # end
  end
end
