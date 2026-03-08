class AddNotNullConstraintsToUser < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :phone, false
    change_column_null :users, :gender, false
    change_column_null :users, :birth_date, false
  end
end
