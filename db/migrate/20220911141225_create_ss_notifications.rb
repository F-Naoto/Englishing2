class CreateSsNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :ss_notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :question_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end

    # add_index :ss_notifications, :visitor_id
    # add_index :ss_notifications, :visited_id
    # add_index :ss_notifications, :question_id
  end
end
