require 'rails_helper'

RSpec.describe TeacherReview, type: :model do
  it "先生レビューを正常に登録できる" do
    teacher_review = create(:teacher_review)
    expect(teacher_review).to be_valid
  end

  it "スコアが空の場合、無効である" do
    teacher_review = build(:teacher_review, score: nil)
    teacher_review.valid?
    expect(teacher_review.errors[:score]).to include("を入力してください")
  end

  it "レビュー内容が空の場合、無効である" do
    teacher_review = build(:teacher_review, content: nil)
    teacher_review.valid?
    expect(teacher_review.errors[:content]).to include("を入力してください")
  end
end
