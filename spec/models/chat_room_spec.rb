# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  describe 'チャットルームの作成' do
    context '正常な場合' do
      it 'チャットルームの作成に成功' do
        chat_room = create(:chat_room)
        expect(chat_room).to be_valid
      end
    end
  end

  describe 'アソシエーション' do
    describe 'チャットルームが削除された場合' do
      it 'チャットルームユーザーも削除される' do
        chat_room = build(:chat_room)
        chat_room.chat_room_users << create(:chat_room_user)
        chat_room.save
        expect { chat_room.destroy }.to change { ChatRoomUser.count }.by(-1)
      end
    end
    describe 'チャットルームが削除された場合' do
      it 'チャットメッセージも削除される' do
        chat_room = build(:chat_room)
        chat_room.chat_messages << create(:chat_message)
        chat_room.save
        expect { chat_room.destroy }.to change { ChatMessage.count }.by(-1)
      end
    end
  end
end
