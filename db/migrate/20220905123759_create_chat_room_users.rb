# frozen_string_literal: true

class CreateChatRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_room_users do |t|
      t.references :chat_room, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.timestamps
    end
  end
end
