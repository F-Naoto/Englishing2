class AddColumnPosterToChatMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_messages, :poster, :boolean, null: false
  end
end
