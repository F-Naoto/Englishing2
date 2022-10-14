require 'rails_helper'

RSpec.describe RoomChannel, type: :channel do
  before do
    @chat_group = create(:chat_group)
    stub_connection
  end

  describe "メッセージの送信" do
    before do
      @message = build(:message, chat_group_id: @chat_group.id) #postメソッド内でメッセージを保存するのでここではbuildするだけ
    end

    context "送信成功" do
      it "グループが選択されている状態でメッセージを送信するとメッセージが一つDBに保存される" do
          subscribe(chat_group_id: @chat_group.id)
          expect(subscription).to be_confirmed
          expect do
           perform :post, message: @message.text
          end. to change(Message, :count).by(1)
      end

      it "グループが選択されている状態でメッセージを送信するとメッセージが接続しているチャネルに配信される" do
          subscribe(chat_group_id: @chat_group.id)
          expect(subscription).to be_confirmed
          expect do
           perform :post, message: @message.text
          end. to have_broadcasted_to("message_channel_#{@chat_group.id}").with{ |data|
            expect(data['message']['text']).to eq @message.text
          }
      end
    end

    context "送信失敗" do
      it "グループが選択されていない状態でメッセージを送信するとメッセージが保存できない" do
          subscribe(chat_group_id: nil)
          expect do
           perform :post, message: @message.text
          end. to raise_error RuntimeError #Must be subscribed! というエラーが出ることを検証
      end
    end

  end
end
