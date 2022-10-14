it '生徒の質問が正しく表示される' do
  visit student_path(other_student)
  expect(page).to have_content "質問一覧（#{Question.count}件）"
  expect(page).to have_content 'タイトルテスト'
  expect(page).to have_content '質問テスト'
end
