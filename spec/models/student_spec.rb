require 'rails_helper'

RSpec.describe Student, type: :model do
  it "生徒名、メールアドレス、パスワード、パスワード確認がある場合、正常に登録できること" do
    student = create(:student)
    expect(student).to be_valid
  end

  it "名前ない場合、無効である" do
    student = build(:student, name: nil)
    student.valid?
    expect(student.errors[:name]).to include("を入力してください", "は2文字以上で入力してください")
  end

  it "メールアドレスがない場合、無効である"  do
    student = build(:student, email: nil)
    student.valid?
    expect(student.errors[:email]).to include("を入力してください")
  end

  it "パスワードがない場合、無効である" do
    student = build(:student, password: nil)
    student.valid?
    expect(student.errors[:password]).to include("を入力してください")
  end

  it "重複したメールアドレスの場合、無効である" do
    create(:student, email: "test@gmail.com")
    student2 = build(:student, email: "test@gmail.com")
    student2.valid?
    expect(student2.errors[:email]).to include("はすでに存在します")
  end

  it "重複したユーザー名の場合、無効である" do
    create(:student, name: "Joe")
    student2 = build(:student, name: "Joe")
    student2.valid?
    expect(student2.errors[:name]).to include("はすでに存在します")
  end

  it "ユーザー名が２文字以下の場合、無効である" do
    student = build(:student, name: "a")
    student.valid?
    expect(student.errors[:name]).to include("は2文字以上で入力してください")
  end

  it "ユーザー名が10文字以上の場合、無効である" do
    student = build(:student, name: "12345678910")
    student.valid?
    expect(student.errors[:name]).to include("は10文字以内で入力してください")
  end

  it "自己紹介が100文字以上の場合、無効である" do
    student = build(:student, self_introduction: "a"*101)
    student.valid?
    expect(student.errors[:self_introduction]).to include("は100文字以内で入力してください")
  end
end
