# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let!(:student) { create(:student) }
  let!(:question) { create(:question) }
  before do
    sign_in student
  end

  describe 'POST /questions/:question_id/likes' do
    it '生徒が質問へいいねに成功' do
      post question_likes_path(question), params: { question_id: question.id }, xhr: true
      expect(response).to render_template 'likes/create'
    end
    it 'いいねが1件保存される' do
      expect do
        post question_likes_path(question), params: { question_id: question.id }, xhr: true
      end.to change(Like, :count).by(1)
    end
  end

  describe 'DELETE /questions/:question_id/likes' do
    before do
      post question_likes_path(question), params: { question_id: question.id }, xhr: true
    end

    it '生徒が質問へのいいね削除に成功' do
      delete question_likes_path(question), params: { question_id: question.id }, xhr: true
      expect(response).to render_template 'likes/destroy'
    end
    it 'いいねが1件削除される' do
      expect do
        delete question_likes_path(question), params: { question_id: question.id }, xhr: true
      end.to change(Like, :count).by(-1)
    end
  end
end
