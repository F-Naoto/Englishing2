require 'rails_helper'

RSpec.describe 'Likes', type: :request do
  let!(:student) { create(:student) }
  let!(:question) { create(:question) }
  before do
    sign_in student
  end
  describe 'POST /questions/:question_id/likes' do
      it 'いいねが1件保存される' , js: true do
        expect{
          post question_likes_path(question), params: { question_id: question.id }
        }.to change( Like, :count).by(1)
      end
  end

  describe 'DELETE /questions/:question_id/likes' do
    it 'リクエストに成功' do
      delete question_likes_path(question)
    end
  end
end
