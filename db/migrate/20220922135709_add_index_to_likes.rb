class AddIndexToLikes < ActiveRecord::Migration[6.0]
  def change
    add_index :likes, [:student_id, :question_id] , unique: true
  end
end
