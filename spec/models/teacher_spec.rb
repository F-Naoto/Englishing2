# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe '先生の登録' do
    context '正常な場合' do
      it '先生を正常に成功する' do
        teacher = create(:teacher)
        expect(teacher).to be_valid
      end
    end
    context '名前が空の場合' do
      it '先生の登録に失敗する' do
        teacher = build(:teacher, name: nil)
        teacher.valid?
        expect(teacher.errors[:name]).to include('を入力してください', 'は2文字以上で入力してください')
      end
    end
    context 'メールアドレスが空の場合' do
      it '先生の登録に失敗する' do
        teacher = build(:teacher, email: nil)
        teacher.valid?
        expect(teacher.errors[:email]).to include('を入力してください')
      end
    end
    context 'パスワードが空の場合' do
      it '先生の登録に失敗する' do
        teacher = build(:teacher, password: nil)
        teacher.valid?
        expect(teacher.errors[:password]).to include('を入力してください')
      end
    end
    context '重複したメールアドレスの場合' do
      it '先生の登録に失敗する' do
        create(:teacher, email: 'test@gmail.com')
        teacher2 = build(:teacher, email: 'test@gmail.com')
        teacher2.valid?
        expect(teacher2.errors[:email]).to include('はすでに存在します')
      end
    end
    context '重複したユーザー名の場合' do
      it '先生の登録に失敗する' do
        create(:teacher, name: 'Joe')
        teacher2 = build(:teacher, name: 'Joe')
        teacher2.valid?
        expect(teacher2.errors[:name]).to include('はすでに存在します')
      end
    end
    context 'ユーザー名が2文字以下の場合' do
      it '先生の登録に失敗する' do
        teacher = build(:teacher, name: 'a')
        teacher.valid?
        expect(teacher.errors[:name]).to include('は2文字以上で入力してください')
      end
    end
    context 'ユーザー名が15文字以上の場合' do
      it '先生の登録に失敗する' do
        teacher = build(:teacher, name: 'a' * 16)
        teacher.valid?
        expect(teacher.errors[:name]).to include('は15文字以内で入力してください')
      end
      it '先生の登録に失敗する' do
        teacher = build(:teacher, name: 'a' * 16)
        teacher.valid?
        expect(teacher.errors[:name]).to include('は15文字以内で入力してください')
      end
    end
    context '自己紹介が100文字以上の場合' do
      it '先生の登録に失敗する' do
        teacher = build(:teacher, self_introduction: 'a' * 101)
        teacher.valid?
        expect(teacher.errors[:self_introduction]).to include('は100文字以内で入力してください')
      end
    end
  end

  describe 'アソシエーション' do
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
