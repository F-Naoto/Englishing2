# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  let!(:student) { create(:student) }
  let!(:teacher) { create(:teacher) }

  describe 'トップページに遷移' do
    context 'ログインしていない場合' do
      before do
        visit root_url
      end
      it 'navbarが正常に表示される' do
        expect(page).to have_content '先生一覧'
        expect(page).to have_content '生徒一覧'
        expect(page).to have_content '質問一覧'
        expect(page).to have_content '先生ランキング'
      end
      it 'アカウント作成ボタンが正常に表示される' do
        expect(page).to have_content '先生アカウントを作成'
        expect(page).to have_content '生徒アカウントを作成'
      end
      it 'アカウントお試しボタンが正常に表示される' do
        expect(page).to have_content '先生をお試し'
        expect(page).to have_content '生徒をお試し'
      end
    end

    context '生徒がログインしている場合' do
      before do
        login_as student, scope: :student
        visit root_url
      end
      it 'navbarが正常に表示される' do
        expect(page).to have_content 'マイページ'
        find('.my_page_btn').click
        expect(page).to have_content '生徒マイページ'
        expect(page).to have_content 'メッセージ'
        expect(page).to have_content 'お知らせ'
        expect(page).to have_content '生徒ログアウト'
      end
      it 'アカウント作成ボタンが正常に表示される' do
        expect(page).to have_content '先生アカウントを作成'
        expect(page).to have_content '生徒アカウントを作成'
      end
      it 'アカウントお試しボタンが正常に表示される' do
        expect(page).to have_content '先生をお試し'
        expect(page).to have_no_content '生徒をお試し'
      end
    end

    context '先生がログインしている場合' do
      before do
        login_as teacher, scope: :teacher
        visit root_url
      end
      it 'navbarが正常に表示される' do
        expect(page).to have_content 'マイページ'
        find('.my_page_btn').click
        expect(page).to have_content '先生マイページ'
        expect(page).to have_content 'メッセージ'
        expect(page).to have_content '先生ログアウト'
      end
      it 'アカウント作成ボタンが正常に表示される' do
        expect(page).to have_content '先生アカウントを作成'
        expect(page).to have_content '生徒アカウントを作成'
      end
      it 'アカウントお試しボタンが正常に表示される' do
        expect(page).to have_content '生徒をお試し'
        expect(page).to have_no_content '先生をお試し'
      end
    end
  end
end
