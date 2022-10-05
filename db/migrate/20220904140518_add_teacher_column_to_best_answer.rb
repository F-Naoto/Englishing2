# frozen_string_literal: true

class AddTeacherColumnToBestAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :best_answers, :teacher_id, :integer, null: false
  end
end
