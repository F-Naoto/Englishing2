class AddColumnAverageScoreToTeacher < ActiveRecord::Migration[6.0]
  def change
    add_column :teachers, :average_score, :float
  end
end
