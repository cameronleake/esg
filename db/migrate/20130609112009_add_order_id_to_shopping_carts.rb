class AddOrderIdToShoppingCarts < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :order_id, :integer
  end
end
