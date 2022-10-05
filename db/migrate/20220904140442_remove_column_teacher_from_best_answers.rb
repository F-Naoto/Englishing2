# frozen_string_literal: true

class RemoveColumnTeacherFromBestAnswers < ActiveRecord::Migration[6.0]
  def change
    remove_column :best_answers, :teacher_id
  end
end
