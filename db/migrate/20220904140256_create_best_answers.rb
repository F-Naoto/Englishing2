# frozen_string_literal: true

class CreateBestAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :best_answers do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
