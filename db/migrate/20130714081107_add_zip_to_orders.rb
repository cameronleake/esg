class AddZipToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :zip, :integer
  end
end
