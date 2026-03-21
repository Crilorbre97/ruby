class CreatePurchases < ActiveRecord::Migration[7.2]
  def change
    create_table :purchases do |t|
      t.integer :price
      t.references :product, null: false, foreign_key: true
      t.references :purchaser, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
