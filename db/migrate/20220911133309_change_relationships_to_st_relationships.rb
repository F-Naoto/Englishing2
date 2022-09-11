class ChangeRelationshipsToStRelationships < ActiveRecord::Migration[6.0]
  def change
    rename_table :relationships, :st_relationships
  end
end
