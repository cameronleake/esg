class RenameColumnInShoppingCarts < ActiveRecord::Migration
  def up
    rename_column :shopping_carts, :staus, :status
  end

  def down
  end
end
