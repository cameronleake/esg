class AddColumnToShoppingCart < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :cart_token, :string
  end
end
