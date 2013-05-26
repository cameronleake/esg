class AddResourcesShoppingCartsTable < ActiveRecord::Migration
  def up
     create_table :resources_shopping_carts do |t|
        t.integer :resource_id
        t.integer :shopping_cart_id
     end 
  end

  def down
     drop_table :resources_shopping_carts
  end
end
