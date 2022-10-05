# frozen_string_literal: true

class ReddColumnStudentIdToBestAnswer < ActiveRecord::Migration[6.0]
  def change
    add_reference :best_answers, :student, null: false, foreign_key: true
  end
end
