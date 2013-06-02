class AddPurchasePriceToDownloads < ActiveRecord::Migration
  def up
    add_column :downloads, :purchase_price_in_cents, :integer
  end
  
  def down
    remove_column :downloads, :purchase_price_in_cents
  end
end
