require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  it "正常に登録できる" do
    chat_room = create(:chat_room)
    expect(chat_room).to be_valid
  end

  describe 'アソシエーションについて' do
    it 'チャットルームが削除されたら、チャットルームユーザーも削除される' do
      chat_room = build(:chat_room)
      chat_room.chat_room_users << create(:chat_room_user)
      chat_room.save
      expect{ chat_room.destroy }.to change{ ChatRoomUser.count }.by(-1)
    end
    it 'チャットルームが削除されたら、チャットメッセージも削除される' do
      chat_room = build(:chat_room)
      chat_room.chat_messages << create(:chat_message)
      chat_room.save
      expect{ chat_room.destroy }.to change{ ChatMessage.count }.by(-1)
    end
  end
end
