require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it "生徒名、メールアドレス、パスワード、パスワード確認がある場合、正常に登録できること" do
    teacher = create(:teacher)
    expect(teacher).to be_valid
  end

  it "名前ない場合、無効である" do
    teacher = build(:teacher, name: nil)
    teacher.valid?
    expect(teacher.errors[:name]).to include("を入力してください", "は2文字以上で入力してください")
  end

  it "メールアドレスがない場合、無効である"  do
    teacher = build(:teacher, email: nil)
    teacher.valid?
    expect(teacher.errors[:email]).to include("を入力してください")
  end

  it "パスワードがない場合、無効である" do
    teacher = build(:teacher, password: nil)
    teacher.valid?
    expect(teacher.errors[:password]).to include("を入力してください")
  end

  it "重複したメールアドレスの場合、無効である" do
    create(:teacher, email: "test@gmail.com")
    teacher2 = build(:teacher, email: "test@gmail.com")
    teacher2.valid?
    expect(teacher2.errors[:email]).to include("はすでに存在します")
  end

  it "重複したユーザー名の場合、無効である" do
    create(:teacher, name: "Joe")
    teacher2 = build(:teacher, name: "Joe")
    teacher2.valid?
    expect(teacher2.errors[:name]).to include("はすでに存在します")
  end

  it "ユーザー名が２文字以下の場合、無効である" do
    teacher = build(:teacher, name: "a")
    teacher.valid?
    expect(teacher.errors[:name]).to include("は2文字以上で入力してください")
  end

  it "ユーザー名が10文字以上の場合、無効である" do
    teacher = build(:teacher, name: "12345678910")
    teacher.valid?
    expect(teacher.errors[:name]).to include("は10文字以内で入力してください")
  end

  it "自己紹介が100文字以上の場合、無効である" do
    teacher = build(:teacher, self_introduction: "a"*101)
    teacher.valid?
    expect(teacher.errors[:self_introduction]).to include("は100文字以内で入力してください")
  end
end
