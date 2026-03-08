class CreateUserAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :user_accounts do |t|
      t.string :username
      t.string :password_digest
      t.string :role
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
