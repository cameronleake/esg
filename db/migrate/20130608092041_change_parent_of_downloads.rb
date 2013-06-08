class ChangeParentOfDownloads < ActiveRecord::Migration
  def up           
    rename_column :downloads, :shopping_cart_id, :order_id
  end

  def down
    rename_column :downloads, :order_id, :shopping_cart_id   
  end
end
