require 'rails_helper'

RSpec.describe Question, type: :model do
  it "正常に登録できる" do
    question = create(:question)
    expect(question).to be_valid
  end
  describe "about title" do
    it "タイトルが空の場合、無効である" do
      question = build(:question, title: nil)
      question.valid?
      expect(question.errors[:title]).to include("を入力してください")
    end
    it "タイトルが20文字以上の場合無効である" do
      question = build(:question, title: "a"*21)
      question.valid?
      expect(question.errors[:title]).to include("は20文字以内で入力してください")
    end
  end
  describe "about content" do
    it "質問内容が空の場合、無効である" do
      question = build(:question, content: nil)
      question.valid?
      expect(question.errors[:content]).to include("を入力してください")
    end
    it "質問内容が200文字以上の場合無効である" do
      question = build(:question, title: "a"*201)
      question.valid?
      expect(question.errors[:title]).to include("は20文字以内で入力してください")
    end
  end
end
