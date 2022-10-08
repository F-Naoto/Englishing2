# frozen_string_literal: true

class ChangeRelationshipsToStRelationships < ActiveRecord::Migration[6.0]
  def change
    rename_table :relationships, :st_relationships
  end
end
