require 'rails_helper'

RSpec.describe ChatRoomUser, type: :model do
  it "正常に登録できる" do
    chat_room_user = create(:chat_room_user)
    expect(chat_room_user).to be_valid
  end

  describe 'アソシエーションについて' do
    it 'チャットルームが削除されたら、チャットルームユーザーも削除される' do
      chat_room = build(:chat_room)
      chat_room.chat_room_users << create(:chat_room_user)
      chat_room.save
      expect{ chat_room.destroy }.to change{ ChatRoomUser.count }.by(-1)
    end
    it '先生が削除されたら、チャットルームユーザーも削除される' do
      teacher = build(:teacher)
      teacher.chat_room_users << create(:chat_room_user)
      teacher.save
      expect{ teacher.destroy }.to change{ ChatRoomUser.count }.by(-1)
    end
    it '生徒が削除されたら、チャットルームユーザーも削除される' do
      student = build(:student)
      student.chat_room_users << create(:chat_room_user)
      student.save
      expect{ student.destroy }.to change{ ChatRoomUser.count }.by(-1)
    end
  end
end
