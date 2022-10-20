require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  let!(:question) { create(:question) }
  let!(:student){ create(:student) }
  let!(:question_params) { { question: { title: 'sample_title', content: 'sample_content'} } }
  let!(:invalid_question_params) { { question: { title: 'sample_title', content: nil } } }

  describe 'GET /question' do
    it 'リクエストが成功する' do
      get questions_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /questions/:id' do
    it 'リクエストが成功する' do
    get questions_path(question)
    expect(response).to have_http_status(200)
    end
  end

  describe 'POST /questions' do
    before do
      sign_in student
    end
    context 'リクエストが成功した場合' do
      it '質問の一覧ページにリダイレクトする' do
      expect{
        post questions_path, params: question_params
      }.to change( Question, :count).by(1)
      expect(response).to redirect_to questions_path
      end
    end
    context 'リクエストが失敗した場合' do
      it '質問の一覧ページにrenderする' do
        post questions_path, params: invalid_question_params
        expect(response).to render_template :index
      end
    end
  end

  describe 'DELETE /questions/:id' do
    it '質問の削除に成功する' do
      sign_in student
      expect{
        delete question_path(question)
      }.to change( Question, :count).by(-1)
      expect(response).to redirect_to questions_path
    end
  end
end
