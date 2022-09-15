class ChangeTeacherReviewsColumnFromIntegerToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :teachers, :average_score, :float
  end
end
