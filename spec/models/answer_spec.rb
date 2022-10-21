# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe '回答の投稿' do
    let!(:answer) { create(:answer, teacher_id: teacher.id, question_id: question.id) }
    let!(:question) { create(:question) }
    let!(:student) { create(:student) }
    let!(:teacher) { create(:teacher) }

    context '正常な場合' do
      it '回答の投稿に成功' do
        answer = create(:answer)
        expect(answer).to be_valid
      end
    end
    context '回答が空の場合' do
      it '回答の投稿に失敗' do
        answer = build(:answer, content: nil)
        answer.valid?
        expect(answer.errors[:content]).to include('を入力してください')
      end
    end
    context '回答が300文字以上の場合' do
      it '回答の投稿に失敗' do
        answer = build(:answer, content: 'a' * 301)
        answer.valid?
        expect(answer.errors[:content]).to include('は300文字以内で入力してください')
      end
    end
  end

  describe 'アソシエーション' do
    context '質問が削除された場合' do
      it '回答も削除される' do
        question = build(:question)
        question.answers << create(:answer)
        question.save
        expect { question.destroy }.to change { Answer.count }.by(-1)
      end
    end
    context '先生が削除された場合' do
      it '回答も削除される' do
        teacher = build(:teacher)
        teacher.answers << create(:answer)
        teacher.save
        expect { teacher.destroy }.to change { Answer.count }.by(-1)
      end
    end
  end
end
