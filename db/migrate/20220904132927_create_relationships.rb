# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.references :follower, foreign_key: { to_table: :students }
      t.references :followed, foreign_key: { to_table: :teachers }

      t.timestamps
    end
    add_index :relationships, %i[follower_id followed_id], unique: true
  end
end
