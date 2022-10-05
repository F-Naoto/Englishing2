# frozen_string_literal: true

class CreateTeacherReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_reviews do |t|
      t.references :student, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true
      t.string :content
      t.integer :score

      t.timestamps
    end
  end
end
