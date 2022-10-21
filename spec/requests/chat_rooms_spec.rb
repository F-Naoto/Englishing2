# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ChatRooms', type: :request do
  let!(:teacher) { create(:teacher) }
  let!(:other_teacher) { create(:teacher) }
  let!(:student) { create(:student) }
  let!(:other_student) { create(:student) }
  let!(:chat_room) { create(:chat_room) }
  let!(:chat_room_user) do
    create(:chat_room_user,
           student_id: student.id,
           teacher_id: teacher.id,
           chat_room_id: chat_room.id)
  end

  describe 'POST /chat_rooms' do
    before do
      sign_in student
    end
    context 'チャットルームが存在しない場合' do
      it 'チャットルームにリダイレクトする' do
        post chat_rooms_path
        expect(response).to redirect_to "/chat_rooms/#{ChatRoom.second.id}"
      end
      it 'チャットルームが1件保存される' do
        expect do
          post chat_rooms_path
        end.to change(ChatRoom, :count).by(1)
      end
    end
    context 'チャットルームが存在する場合' do
      it 'チャットルームにリダイレクトする' do
        post chat_rooms_path, params: { teacher_id: teacher.id }
        expect(response).to redirect_to "/chat_rooms/#{ChatRoom.first.id}"
      end
    end
  end

  describe 'GET /chat_rooms/:id' do
    describe '生徒のリクエスト' do
      context '本人がリクエストした場合' do
        it 'リクエストが成功する' do
          sign_in student
          get chat_room_path(chat_room.id)
          expect(response).to have_http_status(200)
        end
      end
      context '他の生徒がリクエストした場合' do
        it 'リクエストが失敗する' do
          sign_in(other_student)
          get chat_room_path(chat_room.id)
          expect(response).to have_http_status(302)
        end
      end
    end
  end
  describe 'GET /chat_rooms/:id' do
    describe '先生のリクエスト' do
      context '本人がリクエストした場合' do
        it 'リクエストが成功する' do
          sign_in teacher
          get chat_room_path(chat_room.id)
          expect(response).to have_http_status(200)
        end
      end
      context '他の生徒がリクエストした場合' do
        it 'リクエストが失敗する' do
          sign_in(other_teacher)
          get chat_room_path(chat_room.id)
          expect(response).to have_http_status(302)
        end
      end
    end
  end
end
