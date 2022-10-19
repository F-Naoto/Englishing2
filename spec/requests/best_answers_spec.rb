require 'rails_helper'

RSpec.describe 'BestAnswers', type: :request do
  describe 'CREATE  /best_answers' do
    let!(:teacher) { create(:teacher) }
    let!(:student) { create(:student) }
    let!(:question) { create(:question) }
    let!(:best_answer_params) { { best_answer:
      { question_id: question.id,
        teacher_id: teacher.id,
        student_id: student.id } } }
    let!(:bad_best_answer_params) { { best_answer:
      { question_id: question.id,
        teacher_id: teacher.id,
        student_id: nil } } }

    before do
      sign_in(student)
    end

    context 'リクエストが成功した場合' do
      it '質問詳細ページにリダイレクトする' do
        post best_answers_path, params: best_answer_params
        expect(response).to redirect_to question_path(question.id)
      end
      it 'ベストアンサーが1件保存される' do
        expect{
          post best_answers_path, params: best_answer_params
        }.to change( BestAnswer, :count).by(1)
      end
    end
  end
end
