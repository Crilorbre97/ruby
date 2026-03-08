class AddUniquenessConstraintToUsername < ActiveRecord::Migration[7.2]
  def change
    add_index :user_accounts, [ :username ], unique: true
  end
end
