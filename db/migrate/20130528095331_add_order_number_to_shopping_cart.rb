class AddOrderNumberToShoppingCart < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :order_number, :integer
  end
end
