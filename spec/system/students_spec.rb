# frozen_string_literal: true

require 'rails_helper'
require 'devise'

RSpec.describe 'Students', type: :system do
  let!(:student) { create(:student, name: 'student', self_introduction: 'introduction') }
  let!(:teacher) { create(:teacher) }
  let!(:other_student) { create(:student) }

  describe 'ページ遷移確認' do
    context '生徒のログインページに遷移' do
      it '生徒のログインページへのアクセスに成功' do
        visit new_student_session_path
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content 'パスワード'
        expect(current_path).to eq new_student_session_path
      end
    end
    context '生徒の一覧ページに遷移' do
      it '生徒の一覧ページへのアクセスに成功' do
        visit students_path
        student_list = create_list(:student, 3)
        visit students_path
        expect(page).to have_content 'Meet Your Friends'
        expect(page).to have_content student_list[0].name
        expect(page).to have_content student_list[1].name
        expect(page).to have_content student_list[2].name
        expect(current_path).to eq students_path
      end
    end
    context '生徒の新規作成ページに遷移' do
      it '生徒の新規作成ページへのアクセスに成功' do
        visit new_student_registration_path
        expect(page).to have_content '生徒登録'
        expect(page).to have_content '生徒名'
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content 'パスワード（最低６文字）'
        expect(page).to have_content 'パスワード確認'
        expect(page).to have_button '登録'
      end
    end
    context '生徒の編集ページに遷移' do
      it '生徒の編集ページへのアクセスに成功' do
        login_as student, scope: :student
        visit edit_student_registration_path(student)
        expect(page).to have_content '生徒アカウント情報編集'
        expect(page).to have_field 'student[name]', with: student.name
        expect(page).to have_field 'student[email]', with: student.email
        expect(page).to have_field 'student[self_introduction]', with: student.self_introduction
        expect(current_path).to eq edit_student_registration_path(student)
      end
    end
    context '詳細ページに遷移' do
      let!(:question) { create(:question, student_id: other_student.id) }
      it '詳細ページへのアクセスに成功' do
        visit student_path(student)
        expect(page).to have_content 'Student Profile'
        expect(page).to have_content student.name
        expect(page).to have_content 'フォロー（先生）'
        expect(page).to have_content 'フォロー（生徒）'
        expect(page).to have_content 'フォロワー（生徒）'
        expect(page).to have_content 'まだ質問はありません。'
        expect(current_path).to eq student_path(student)
      end
    end
  end

  describe '生徒のログイン' do
    before do
      visit new_student_session_path
    end
    context 'フォームの入力値が正常な場合' do
      it 'ログインに成功' do
        fill_in 'student_email',	with: student.email.to_s
        fill_in 'student_password',	with: student.password.to_s
        click_button 'ログイン'
        expect(current_path).to eq student_path(student.id)
        expect(page).to have_content 'ログインしました。'
      end
    end
    context 'メールアドレスが未入力の場合' do
      it 'ログインに失敗' do
        fill_in 'student_email',	with: nil
        fill_in 'student_password',	with: student.password.to_s
        click_button 'ログイン'
        expect(current_path).to eq new_student_session_path
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
    context 'パスワードが違う場合' do
      it 'ログインに失敗' do
        fill_in 'student_email',	with: student.email.to_s
        fill_in 'student_password',	with: 'false_password'
        click_button 'ログイン'
        expect(current_path).to eq new_student_session_path
        expect(page).to have_content 'パスワードが違います。'
      end
    end
  end

  describe '生徒のログアウト' do
    before do
      login_as student, scope: :student
      visit root_url
    end
    context '正常な場合' do
      it 'ログアウトに成功' do
        find('.my_page_btn').click
        find('.logout').click
        expect(current_path).to eq '/'
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end

  describe '生徒の検索' do
    before do
      visit students_path
      fill_in 'キーワードを入力', with: teacher.self_introduction.to_s
      click_button '検索'
    end
    context 'キーワードを入力して検索した場合' do
      it '該当する生徒が表示される' do
        expect(page).to have_content student.self_introduction.to_s
        expect(page).to have_content student.name.to_s
        expect(page).to have_link student.name.to_s, href: student_path(student.id)
      end
    end
  end

  describe 'ユーザーの新規作成' do
    before do
      visit new_student_registration_path
    end
    context 'フォームの入力値が正常な場合' do
      it '生徒の登録に成功' do
        fill_in 'student[name]',	with: 'test_name'
        fill_in 'student[email]',	with: 'test@gmail.com'
        fill_in 'student[password]',	with: 'registration_password'
        fill_in 'student[password_confirmation]',	with: 'registration_password'
        click_button '登録'
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end
    context '名前が未入力の場合' do
      it '生徒の登録に失敗' do
        fill_in 'student[name]',	with: nil
        fill_in 'student[email]',	with: 'registration_email'
        fill_in 'student[password]',	with: 'registration_password'
        fill_in 'student[password_confirmation]',	with: 'registration_password'
        click_button '登録'
        expect(current_path).to eq '/students'
        expect(page).to have_content '※名前を入力してください'
      end
    end
    context 'すでにログインしている場合' do
      it 'ログインしている場合、マイページに遷移する' do
        login_as student, scope: :student
        visit new_student_registration_path
        expect(current_path).to eq "/students/#{student.id}"
        expect(page).to have_content 'すでにログインしています。'
      end
    end
  end

  describe '生徒の編集' do
    before do
      login_as student, scope: :student
      visit edit_student_registration_path(student)
    end
    context 'フォームの入力値が正常な場合' do
      it '画像の編集に成功' do
        attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/image/profile_img.jpg"
        fill_in 'student[current_password]', with: student.password.to_s
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(page).to have_selector("img[src$='profile_img.jpg']")
        expect(current_path).to eq student_path(student)
      end
      it '生徒名の編集に成功' do
        fill_in 'student[name]', with: 'changed_name'
        fill_in 'student[current_password]', with: student.password.to_s
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq student_path(student)
      end
      it 'メールアドレスの編集に成功' do
        fill_in 'student[email]', with: 'change_email@gmail.com'
        fill_in 'student[current_password]', with: student.password.to_s
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq student_path(student)
      end
      it 'パスワードの編集に成功' do
        fill_in 'student[password]', with: 'new_password'
        fill_in 'student[password_confirmation]', with: 'new_password'
        fill_in 'student[current_password]', with: student.password.to_s
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq student_path(student)
      end
    end
    context '現在のパスワードを入力しない場合' do
      it '編集に失敗' do
        fill_in 'student[email]', with: 'change_email@gmail.com'
        click_button '変更する'
        expect(page).to have_content '現在のパスワードを入力してください'
        expect(current_path).to eq students_path
      end
    end
  end
end
