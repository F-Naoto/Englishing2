require 'rails_helper'

RSpec.describe ChatMessage, type: :model do
  describe 'メッセージの投稿' do
    context 'フォームの入力値が正常な場合' do
      it "メッセージの投稿に成功" do
        chat_message = create(:chat_message)
        expect(chat_message).to be_valid
      end
    end
  end
    context 'メッセージの内容が空の場合' do
      it "メッセージの投稿に失敗" do
        chat_message = build(:chat_message, content: nil)
        chat_message.valid?
        expect(chat_message.errors[:content]).to include("を入力してください")
      end
    end
    context '内容が200文字以上の場合' do
      it "メッセージの投稿に失敗" do
        chat_message = build(:chat_message, content: "a"*201)
        chat_message.valid?
        expect(chat_message.errors[:content]).to include("は200文字以内で入力してください")
      end
    end

  describe 'アソシエーション' do
    context 'チャットルームが削除された場合' do
      it 'メッセージも削除される' do
        chat_room = build(:chat_room)
        chat_room.chat_messages << create(:chat_message)
        chat_room.save
        expect{ chat_room.destroy }.to change{ ChatMessage.count }.by(-1)
      end
    end
    context '先生が削除された場合' do
      it 'メッセージも削除される' do
        teacher = build(:teacher)
        teacher.chat_messages << create(:chat_message)
        teacher.save
        expect{ teacher.destroy }.to change{ ChatMessage.count }.by(-1)
      end
    end
    context '生徒が削除されたら場合' do
      it 'メッセージも削除される' do
        student = build(:student)
        student.chat_messages << create(:chat_message)
        student.save
        expect{ student.destroy }.to change{ ChatMessage.count }.by(-1)
      end
    end
  end
end
