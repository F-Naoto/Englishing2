require 'rails_helper'

RSpec.describe Answer, type: :model do
  it "正常に登録できる" do
    answer = create(:answer)
    expect(answer).to be_valid
  end

  it "回答が空の場合、無効である" do
    answer = build(:answer, content: nil)
    answer.valid?
    expect(answer.errors[:content]).to include("を入力してください")
  end

  it "回答が300文字以上の場合、無効である" do
    answer = build(:answer, content: "a"*301)
    answer.valid?
    expect(answer.errors[:content]).to include("は300文字以内で入力してください")
  end

  describe 'アソシエーションについて' do
    it '質問が削除されたら、回答も削除される' do
      question = build(:question)
      question.answers << create(:answer)
      question.save
      expect{ question.destroy }.to change{ Answer.count }.by(-1)
    end
    it '先生が削除されたら、回答も削除される' do
      teacher = build(:teacher)
      teacher.answers << create(:answer)
      teacher.save
      expect{ teacher.destroy }.to change{ Answer.count }.by(-1)
    end
  end
end
