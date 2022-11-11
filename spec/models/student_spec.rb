# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  describe '生徒の登録' do
    context '正常な場合' do
      it '生徒の登録に成功' do
        student = create(:student)
        expect(student).to be_valid
      end
    end
    context '名前が空の場合' do
      it '生徒の登録に失敗する' do
        student = build(:student, name: nil)
        student.valid?
        expect(student.errors[:name]).to include('を入力してください', 'は2文字以上で入力してください')
      end
    end
    context 'メールアドレスが空の場合' do
      it '生徒の登録に失敗する' do
        student = build(:student, email: nil)
        student.valid?
        expect(student.errors[:email]).to include('を入力してください')
      end
    end
    context 'パスワードが空の場合' do
      it '生徒の登録に失敗する' do
        student = build(:student, password: nil)
        student.valid?
        expect(student.errors[:password]).to include('を入力してください')
      end
    end
    context '重複したメールアドレスの場合' do
      it '生徒の登録に失敗する' do
        create(:student, email: 'test@gmail.com')
        student2 = build(:student, email: 'test@gmail.com')
        student2.valid?
        expect(student2.errors[:email]).to include('はすでに存在します')
      end
    end
    context '重複したユーザー名の場合' do
      it '生徒の登録に失敗する' do
        create(:student, name: 'Joe')
        student2 = build(:student, name: 'Joe')
        student2.valid?
        expect(student2.errors[:name]).to include('はすでに存在します')
      end
    end
    context 'ユーザー名が２文字以下の場合' do
      it '生徒の登録に失敗する' do
        student = build(:student, name: 'a')
        student.valid?
        expect(student.errors[:name]).to include('は2文字以上で入力してください')
      end
    end
    context 'ユーザー名が10文字以上の場合' do
      it '生徒の登録に失敗する' do
        student = build(:student, name: 'a' * 16)
        student.valid?
        expect(student.errors[:name]).to include('は15文字以内で入力してください')
      end
    end
    context '自己紹介が100文字以上の場合' do
      it '生徒の登録に失敗する' do
        student = build(:student, self_introduction: 'a' * 101)
        student.valid?
        expect(student.errors[:self_introduction]).to include('は100文字以内で入力してください')
      end
    end
  end

  describe 'アソシエーション' do
    context '生徒が削除された場合' do
      it '質問も削除される' do
        student = build(:student)
        student.questions << create(:question)
        student.save
        expect { student.destroy }.to change { Question.count }.by(-1)
      end
    end
  end
end
