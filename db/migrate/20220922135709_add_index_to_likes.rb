# frozen_string_literal: true

class AddIndexToLikes < ActiveRecord::Migration[6.0]
  def change
    add_index :likes, %i[student_id question_id], unique: true
  end
end
