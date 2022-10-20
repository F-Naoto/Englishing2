# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Answers', type: :request do
  let!(:teacher) { create(:teacher) }
  let!(:student) { create(:student) }
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer) }
  let!(:answer_params) { { answer: { content: 'sample answer', question_id: question.id } } }
  let!(:invalid_answer_params) { { answer: { content: nil, question_id: question.id } } }

  describe 'POST /answers' do
    before do
      sign_in(teacher)
    end
    context 'パラメーターが正常な場合' do
      it '質問の詳細ページにリダイレクトする' do
        post answers_path, params: answer_params
        expect(response).to redirect_to "/questions/#{question.id}"
      end
      it 'Answerが1件保存される' do
        expect do
          post answers_path, params: answer_params
        end.to change(Answer, :count).by(1)
      end
    end
    context 'パラメータが不正な場合' do
      it '質問の詳細ページにrenderする' do
        post answers_path, params: invalid_answer_params
        expect(response).to redirect_to "/questions/#{question.id}"
      end
    end
  end
end
