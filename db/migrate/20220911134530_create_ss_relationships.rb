# frozen_string_literal: true

class CreateSsRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :ss_relationships do |t|
      t.references :follower, foreign_key: { to_table: :students }
      t.references :followed, foreign_key: { to_table: :students }

      t.timestamps
    end
    add_index :ss_relationships, %i[follower_id followed_id], unique: true
  end
end
