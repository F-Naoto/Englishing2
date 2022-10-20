require 'rails_helper'
require 'devise'

RSpec.describe "Questions", type: :system do
  let!(:teacher) { create(:teacher) }
  let!(:student) { create(:student) }
  let!(:other_student) { create(:student) }
  let!(:question) { create(:question, student_id: student.id) }
  let!(:other_question) { create(:question, student_id: other_student.id) }
  let!(:best_answer) { create(:best_answer, question_id: question.id, student_id: student.id, teacher_id: teacher.id) }

  describe '先生が質問一覧ページに遷移' do
    before do
      login_as teacher, scope: :teacher
      visit questions_path
    end
    context '未解決の質問がある場合' do
      it '回答リンクが機能する' do
        expect(page).to have_link '回答する'
        click_link '回答する'
        expect(current_path).to eq question_path(other_question.id)
      end
      it 'タイトルと生徒名が正常に表示される' do
        expect(page).to have_content other_student.name
        expect(page).to have_content other_question.title
      end
    end
    context '解決済みの質問がある場合' do
      it '解決済みが表示される' do
        expect(page).to have_content '解決済み'
      end
      it 'タイトルと生徒名が正常に表示される' do
        expect(page).to have_content student.name
        expect(page).to have_content question.title
      end
    end
  end

  describe '生徒が質問一覧ページに遷移' do
    context '生徒自身の質問がある場合' do
      it '削除リンクが表示される' do
        login_as other_student, scope: :student
        visit questions_path
        expect(page).to have_link '削除する'
        click_link '削除する'
        expect(current_path).to eq questions_path
      end
    end
  end

  describe '質問の投稿' do
    before do
      login_as student, scope: :student
      visit questions_path
    end
    context 'フォームの入力値が正常な場合' do
      it '質問の投稿に成功' do
        fill_in 'question[title]', with: 'タイトルテスト'
        fill_in 'question[content]', with: '質問テスト'
        click_on '質問する'
        expect(page).to have_content '質問を投稿しました'
      end
    end
    context 'タイトルと質問内容が未入力の場合' do
      it '質問の投稿に失敗' do
        fill_in 'question[title]', with: nil
        fill_in 'question[content]', with: nil
        click_on '質問する'
        expect(page).to  have_content '質問を投稿できませんでした。'
        expect(page).to  have_content '※タイトルを入力してください'
        expect(page).to  have_content '※質問内容を入力してください'
      end
    end
  end

  describe '生徒が質問を検索' do
    context 'フォームにキーワードを入力して検索した場合' do
      it '該当する生徒が表示される' do
        visit questions_path
        fill_in 'キーワードを入力', with: question.content
        click_on '検索'
        expect(page).to  have_content student.name
      end
    end
  end

  describe '質問への回答' do
    before do
      login_as teacher, scope: :teacher
      visit question_path(other_question)
      fill_in '内容', with: 'test_answer'
      click_on '回答する'
    end
    context '質問に初めて回答する場合' do
      it '回答に成功' do
        expect(page).to have_content '回答を投稿しました。'
      end
    end
    context '同じ質問に回答する場合' do
      it '回答に失敗' do
        fill_in '内容', with: 'test_answer'
        click_on '回答する'
        expect(page).to have_content '回答に失敗しました。'
      end
    end
  end
end
