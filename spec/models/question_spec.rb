# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '質問の投稿' do
    context 'フォームの入力値が正常な場合' do
      it '質問を正常に投稿できる' do
        question = create(:question)
        expect(question).to be_valid
      end
    end
  end
  context 'フォームの入力値が空の場合' do
    it '質問の投稿に失敗する' do
      question = build(:question, title: nil)
      question.valid?
      expect(question.errors[:title]).to include('を入力してください')
    end
  end
  context 'タイトルが20文字以上の場合' do
    it '質問の投稿に失敗する' do
      question = build(:question, title: 'a' * 21)
      question.valid?
      expect(question.errors[:title]).to include('は20文字以内で入力してください')
    end
  end
  context '質問内容が空の場合' do
    it '質問の投稿に失敗する' do
      question = build(:question, content: nil)
      question.valid?
      expect(question.errors[:content]).to include('を入力してください')
    end
  end
  context '質問内容が200文字以上の場合' do
    it '質問の投稿に失敗する' do
      question = build(:question, content: 'a' * 201)
      question.valid?
      expect(question.errors[:content]).to include('は200文字以内で入力してください')
    end
  end
end
