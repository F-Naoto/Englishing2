require 'rails_helper'
require 'devise'

RSpec.describe "Teachers", type: :system do
  let!(:teacher) { create(:teacher, name: "teacher", self_introduction: "introduction", average_score:1) }
  let!(:other_teacher) { create(:teacher, name: "other_teacher", average_score:3) }
  let!(:other_teacher2) { create(:teacher, name: "other_teacher2", average_score:5)  }
  let!(:teacher) { create(:teacher)}
  # let!(:answer) { create(:answer) }
  let!(:question) { create(:question) }

  describe 'ページ遷移確認' do
    context '先生のログインページに遷移' do
      it '先生のログインページへのアクセスに成功' do
        visit new_teacher_session_path
        expect(page).to have_content "メールアドレス"
        expect(page).to have_content "パスワード"
        expect(current_path).to eq new_teacher_session_path
      end
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
    end
    context '先生の新規作成ページに遷移' do
      it '先生の新規作成ページへのアクセスに成功' do
        visit new_teacher_registration_path
        expect(page).to have_content '先生登録'
        expect(page).to have_content '先生名'
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content 'パスワード（最低６文字）'
        expect(page).to have_content 'パスワード確認'
        expect(page).to have_button '登録'
      end
    end
    context '先生の編集ページに遷移' do
      it '先生の編集ページへのアクセスに成功' do
        login_as teacher, scope: :teacher
        visit edit_teacher_registration_path(teacher)
        expect(page).to have_content '先生アカウント情報編集'
        expect(page).to have_field 'teacher[name]', with: teacher.name
        expect(page).to have_field 'teacher[email]', with: teacher.email
        expect(page).to have_field 'teacher[self_introduction]', with: teacher.self_introduction
        expect(current_path).to eq edit_teacher_registration_path(teacher)
      end
    end
    context '先生の詳細ページに遷移' do
      it '先生の詳細ページへのアクセスに成功' do
        login_as teacher, scope: :teacher
        visit teacher_path(other_teacher)
        expect(page).to have_content 'Teacher Profile'
        expect(page).to have_content other_teacher.name
        expect(page).to have_content '回答数'
        expect(page).to have_content "評価"
        expect(page).to have_content 'フォロワー（生徒）'
        expect(page).to have_content 'レビューはまだありません。'
        expect(current_path).to eq teacher_path(other_teacher)
      end
    end
  end

  describe '先生のログイン' do
    before do
      visit new_teacher_session_path
    end
    context 'フォームの入力値が正常な場合' do
      it 'ログインに成功' do
        fill_in 'teacher_email',	with: "#{teacher.email}"
        fill_in 'teacher_password',	with: "#{teacher.password}"
        click_button 'ログイン'
        expect(current_path).to eq teacher_path(teacher.id)
        expect(page).to have_content 'ログインしました。'
      end
    end
    context 'メールアドレスが未入力の場合' do
      it 'ログインに失敗' do
        fill_in 'teacher_email',	with: nil
        fill_in 'teacher_password',	with: "#{teacher.password}"
        click_button 'ログイン'
        expect(current_path).to eq new_teacher_session_path
        expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      end
    end
    context 'パスワードが違う場合' do
      it 'ログインに失敗' do
        fill_in 'teacher_email',	with: "#{teacher.email}"
        fill_in 'teacher_password',	with: "false_password"
        click_button 'ログイン'
        expect(current_path).to eq new_teacher_session_path
        expect(page).to have_content 'パスワードが違います。'
      end
    end
  end

  describe '先生のログアウト' do
    before do
      login_as teacher, scope: :teacher
      visit root_url
    end
    context '正常な場合' do
      it 'ログアウトに成功' do
        find(".my_page_btn").click
        find(".logout").click
        expect(current_path).to eq "/"
        expect(page).to have_content 'ログアウトしました。'
      end
    end
  end

  describe '先生の検索' do
    before do
      visit teachers_path
    end
    context 'キーワードを入力して検索した場合' do
      it '情報が正常に表示される' do
        fill_in 'キーワードを入力', with: "#{teacher.self_introduction}"
        click_button '検索'
        expect(page).to have_content "#{teacher.self_introduction}"
        expect(page).to have_content "#{teacher.name}"
        expect(page).to have_content "#{teacher.average_score}"
        expect(page).to have_link "#{teacher.name}", href: teacher_path(teacher.id)
      end
    end
    context '先生名を入力して検索した場合' do
      it '情報が正常に表示される' do
        fill_in '先生名を入力', with: "#{teacher.name}"
        click_button '検索'
        expect(page).to have_content "#{teacher.self_introduction}"
        expect(page).to have_content "#{teacher.name}"
        expect(page).to have_content "#{teacher.average_score}"
        expect(page).to have_link "#{teacher.name}", href: teacher_path(teacher.id)
      end
    end
    context 'レビュースコアを選び、検索した場合' do
      it '情報が正常に表示される' do
        find('#q_average_score_gt_3').click
        click_button '検索'
        expect(page).to have_content "#{other_teacher2.name}"
        expect(page).to have_content "#{other_teacher2.average_score}"
      end
    end
  end

  describe '先生の編集' do
    before do
      login_as teacher, scope: :teacher
      visit edit_teacher_registration_path(teacher)
    end
    context 'フォームの入力値が正常な場合' do
      it '画像の編集に成功' do
        attach_file 'プロフィール画像', "#{Rails.root}/spec/fixtures/image/profile_img.jpg"
        fill_in 'teacher[current_password]', with: "#{teacher.password}"
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
        expect(current_path).to eq teacher_path(teacher)
      end
      it '先生名の編集に成功' do
        visit edit_teacher_registration_path(teacher)
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
    end
    context '現在のパスワードを入力しない場合' do
      it '編集に失敗' do
        fill_in 'teacher[email]', with: "change_email@gmail.com"
        click_button '変更する'
        expect(page).to have_content '現在のパスワードを入力してください'
        expect(current_path).to eq teachers_path
      end
    end
  end
end
