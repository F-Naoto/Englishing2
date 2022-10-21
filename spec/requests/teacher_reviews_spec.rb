# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TeacherReviews', type: :request do
  let!(:teacher) { create(:teacher) }
  let!(:student) { create(:student) }
  let!(:review_params) do
    { teacher_review:
                         { teacher_id: teacher.id,
                           score: 4,
                           content: 'sample_review' } }
  end
  let!(:invalid_review_params) do
    { teacher_review:
                             { teacher_id: teacher.id,
                               score: 4,
                               content: nil } }
  end

  before do
    sign_in student
  end

  describe 'GET /teachers/:teacher_id/teacher_reviews' do
    it 'リクエストに成功する' do
      get teacher_teacher_reviews_path(teacher)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /teachers/:teacher_id/teacher_reviews' do
    context 'パラメーターが正常な場合' do
      it '先生のレビューに成功する' do
        post teacher_teacher_reviews_path(teacher), params: review_params
        expect(response).to redirect_to teacher_teacher_reviews_path(teacher)
      end
      it 'TeacherReviewが1件増える' do
        expect do
          post teacher_teacher_reviews_path(teacher), params: review_params
        end.to change(TeacherReview, :count).by(1)
      end
    end
    context 'パラメーターが不正な場合' do
      it '先生の詳細画面へリダイレクトする' do
        post teacher_teacher_reviews_path(teacher), params: invalid_review_params
        expect(response).to redirect_to teacher_path(teacher)
      end
    end
  end

  describe 'GET /teacher_reviews/ranking' do
    it 'リクエストに成功する' do
      get teacher_reviews_ranking_path
      expect(response).to have_http_status(200)
    end
  end
end
