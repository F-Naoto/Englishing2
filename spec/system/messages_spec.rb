# frozen_string_literal: true

require 'rails_helper'
require 'devise'

RSpec.describe 'Messages', type: :system do
  describe 'メッセージページに遷移' do
    let!(:student) { create(:student) }
    let!(:teacher) { create(:teacher) }
    let!(:chat_room) { create(:chat_room, id: 1) }
    let!(:chat_room_user) { create(:chat_room_user, chat_room_id: chat_room.id, student_id: student.id, teacher_id: teacher.id) }
    context '生徒がメッセージページに遷移' do
      before do
        login_as student, scope: :student
        visit chat_room_path(chat_room)
      end
      it 'メッセージページへのアクセスに成功' do
        expect(page).to have_content "#{teacher.name}先生に質問"
        expect(page).to have_content teacher.name
        expect(page).to have_field 'メッセージを入力したらボタンをクリック'
        expect(current_path).to eq chat_room_path(chat_room)
      end
    end
    context '先生がメッセージページに遷移' do
      before do
        login_as teacher, scope: :teacher
        visit chat_room_path(chat_room)
      end
      it 'メッセージページへのアクセスに成功' do
        expect(page).to have_content "#{teacher.name}先生に質問"
        expect(page).to have_content student.name
        expect(page).to have_field 'メッセージを入力したらボタンをクリック'
        expect(current_path).to eq chat_room_path(chat_room)
      end
    end
  end
end
