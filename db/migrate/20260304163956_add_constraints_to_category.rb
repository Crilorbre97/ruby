class AddConstraintsToCategory < ActiveRecord::Migration[7.2]
  def change
    change_column_null :categories, :label, false

    add_index :categories, [:label], unique: true
  end
end
