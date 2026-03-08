class AddNotNullConstraintsToUserAccount < ActiveRecord::Migration[7.2]
  def change
    change_column_null :user_accounts, :username, false
    change_column_null :user_accounts, :password_digest, false
    change_column_null :user_accounts, :role, false
  end
end
