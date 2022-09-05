class Add < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :name, :text, null: false
    add_column :students, :self_introduction, :text, length: {minimum:1, maximum:100}
  end
end
