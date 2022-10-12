require 'rails_helper'

RSpec.describe BestAnswer, type: :model do
  describe 'アソシエーションについて' do
    it '質問が削除されたら、ベストアンサーも削除される' do
      question = build(:question)
      question.best_answers << create(:best_answer)
      question.save
      expect{ question.destroy }.to change{ BestAnswer.count }.by(-1)
    end
    it '生徒が削除されたら、ベストアンサーも削除される' do
      student = build(:student)
      student.best_answers << create(:best_answer)
      student.save
      expect{ student.destroy }.to change{ BestAnswer.count }.by(-1)
    end
    it '先生が削除されたら、ベストアンサーも削除される' do
      teacher = build(:teacher)
      teacher.best_answers << create(:best_answer)
      teacher.save
      expect{ teacher.destroy }.to change{ BestAnswer.count }.by(-1)
    end
  end
end
