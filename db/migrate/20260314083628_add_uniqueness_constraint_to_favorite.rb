class AddUniquenessConstraintToFavorite < ActiveRecord::Migration[7.2]
  def change
    add_index :favorites, [ :user_id, :product_id ], unique: true
  end
end
