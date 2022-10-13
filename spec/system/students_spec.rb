require 'rails_helper'
require 'devise'

RSpec.describe "Students", type: :system do
  let!(:student) { create(:student, name: "student", self_introduction: "introduction") }
  let(:other_student) { create(:student)}
  describe 'ページ遷移確認' do
    before do
      visit students_path
    end
    context '生徒の一覧ページに遷移' do
      it '生徒の一覧ページへのアクセスに成功' do
        student_list = create_list(:student, 3)
        visit students_path
        expect(page).to have_content 'Meet Your Friends'
        expect(page).to have_content student_list[0].name
        expect(page).to have_content student_list[1].name
        expect(page).to have_content student_list[2].name
        expect(current_path).to eq students_path
      end
      # it '生徒の画像が表示される' do
      #   student_list = create_list(:student, 3)
      #   expect(page).to have_content 'Meet Your Friends'
      #   expect(page).to have_content student_list[0].name
      #   expect(page).to have_content student_list[1].name
      #   expect(page).to have_content student_list[2].name
      #   expect(current_path).to eq students_path
      # end
      it 'キーワードを入力して検索した場合、生徒名と自己紹介が表示される' do
        fill_in 'キーワードを入力', with: "introduction"
        click_button '検索'
        expect(page).to have_content "#{student.self_introduction}"
        expect(page).to have_content "#{student.name}"
      end
      it 'キーワードを入力して検索した場合、生徒詳細ページへのリンクが正常に機能する' do
        fill_in 'キーワードを入力', with: "introduction"
        click_button '検索'
        expect(page).to have_link "#{student.name}", href: student_path(student.id)
      end
      it '生徒名を入力して検索できる' do
        fill_in '生徒名を入力', with: "#{student.name}"
        click_button '検索'
        expect(page).to have_link "#{student.name}"
      end
    end
    # context '生徒の新規作成ページに遷移' do
    #   it '生徒の新規作成ページへのアクセスに成功' do
    #     visit new_student_session_path
    #     expect(page).to have_content 'Meet Your Friends'
    #     expect(page).to have_content 'Meet Your Friends'
    #     expect(page).to have_content '生徒新規作成'
    #     expect(current_path).to eq new_student_path
    #   end
    # end
    context '生徒の編集ページに遷移' do
      before do
        login_as student, scope: :student
        visit edit_student_registration_path(student)
      end
      it '生徒の編集ページへのアクセスに成功' do
        expect(page).to have_content '生徒アカウント情報編集'
        expect(page).to have_field 'student[name]', with: student.name
        expect(page).to have_field 'student[email]', with: student.email
        expect(page).to have_field 'student[self_introduction]', with: student.self_introduction
        expect(current_path).to eq edit_student_registration_path(student)
      end
      it 'ユーザー名の編集に成功' do
        fill_in 'student[name]', with: "#{student.name}"
        fill_in 'student[current_password]', with: "#{student.password}"
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq student_path(student)
      end
      it 'メールアドレスの編集に成功' do
        fill_in 'student[email]', with: "change_email@gmail.com"
        fill_in 'student[current_password]', with: "#{student.password}"
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq student_path(student)
      end
      it 'パスワードの編集に成功' do
        fill_in 'student[password]', with: "new_password"
        fill_in 'student[password_confirmation]', with: 'new_password'
        fill_in 'student[current_password]', with: "#{student.password}"
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq student_path(student)
      end
      it '編集に失敗' do
        fill_in 'student[email]', with: "change_email@gmail.com"
        click_button '変更する'
        expect(page).to have_content '現在のパスワードを入力してください'
        expect(current_path).to eq students_path
      end
    end

    context '生徒の詳細ページに遷移' do
      let!(:question) { create(:question, student_id: other_student.id)}

      it '生徒の詳細ページへのアクセスに成功' do
        visit student_path(student)
        expect(page).to have_content 'Student Profile'
        expect(page).to have_content student.name
        expect(page).to have_content 'フォロー（先生）'
        expect(page).to have_content 'フォロー（生徒）'
        expect(page).to have_content 'フォロワー（生徒）'
        expect(page).to have_content 'まだ質問はありません。'
        expect(current_path).to eq student_path(student)
      end
      it '生徒の質問が正しく表示される' do
        visit student_path(other_student)
        expect(page).to have_content "質問一覧（#{Question.count}件）"
        expect(page).to have_content 'タイトルテスト'
        expect(page).to have_content '質問テスト'
      end
      # it 'ユーザーをフォロー、フォロー解除できる' do
      #   login_as student, scope: :student
      #   visit student_path(other_student)
      #   expect {
      #     click_on 'Follow'
      #     sleep 0.5
      #   }.to change { SsRelationship.count }.by(1)
      # end
    end
  end
end
