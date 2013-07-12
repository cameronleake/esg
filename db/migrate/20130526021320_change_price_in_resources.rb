class ChangePriceInResources < ActiveRecord::Migration
  def up
    add_column :resources, :price_in_cents, :integer, :default => 0
    add_column :resources, :currency, :string, :default => 'AUD'
  end

  def down
    remove_column :resources, :currency 
    remove_column :resources, :price_in_cents
  end
end
