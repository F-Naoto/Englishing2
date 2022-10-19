require 'rails_helper'

RSpec.describe BestAnswer, type: :model do
  describe 'アソシエーション' do
    context '質問が削除された場合' do
      it 'ベストアンサーも削除される' do
        question = build(:question)
        question.best_answers << create(:best_answer)
        question.save
        expect{ question.destroy }.to change{ BestAnswer.count }.by(-1)
      end
    end
    context '生徒が削除された場合' do
      it 'ベストアンサーも削除される' do
        student = build(:student)
        student.best_answers << create(:best_answer)
        student.save
        expect{ student.destroy }.to change{ BestAnswer.count }.by(-1)
      end
    end
    context '先生が削除された場合' do
      it 'ベストアンサーも削除される' do
        teacher = build(:teacher)
        teacher.best_answers << create(:best_answer)
        teacher.save
        expect{ teacher.destroy }.to change{ BestAnswer.count }.by(-1)
      end
    end
  end
end
