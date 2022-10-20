# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatRoomUser, type: :model do
  describe 'チャットルームユーザーの作成' do
    context '正常な場合' do
      it 'チャットルームの作成に成功' do
        chat_room_user = create(:chat_room_user)
        expect(chat_room_user).to be_valid
      end
    end
  end

  describe 'アソシエーション' do
    context 'チャットルームが削除された場合' do
      it 'チャットルームユーザーも削除される' do
        chat_room = build(:chat_room)
        chat_room.chat_room_users << create(:chat_room_user)
        chat_room.save
        expect { chat_room.destroy }.to change { ChatRoomUser.count }.by(-1)
      end
    end
    context '先生が削除された場合' do
      it 'チャットルームユーザーも削除される' do
        teacher = build(:teacher)
        teacher.chat_room_users << create(:chat_room_user)
        teacher.save
        expect { teacher.destroy }.to change { ChatRoomUser.count }.by(-1)
      end
    end
    context '生徒が削除された場合' do
      it 'チャットルームユーザーも削除される' do
        student = build(:student)
        student.chat_room_users << create(:chat_room_user)
        student.save
        expect { student.destroy }.to change { ChatRoomUser.count }.by(-1)
      end
    end
  end
end
