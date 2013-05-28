class ChangeColumnsInDownloads < ActiveRecord::Migration
  def up
    rename_column :downloads, :user_id, :shopping_cart_id
  end

  def down
    rename_column :downloads, :shopping_cart_id, :user_id
  end
end
