class AddColumnToShoppingCarts < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :staus, :string
  end
end
