class ChangeDefaultForCurrencyInResources < ActiveRecord::Migration
  def up
    change_column :resources, :currency, :string, :default => "USD"
  end

  def down
    change_column :resources, :currency, :string, :default => "AUD"
  end
end
