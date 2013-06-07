class AddPurchasedAtToShoppingCart < ActiveRecord::Migration
  def up
    add_column :shopping_carts, :purchased_at, :datetime
    remove_column :shopping_carts, :payment_verified
  end
  
  def down
    remove_column :shopping_carts, :purchased_at
    add_column :shopping_carts, :payment_verified, :boolean, :default => false
  end
end
