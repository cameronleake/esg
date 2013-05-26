class ChangePriceInResources < ActiveRecord::Migration
  def up
    change_column :resources, :price_in_cents, :integer, :default => 0
    add_column :resources, :currency, :string, :default => 'AUD'
  end

  def down
    remove_column :resources, :currency
  end
end
