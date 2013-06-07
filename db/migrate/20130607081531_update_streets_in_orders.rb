class UpdateStreetsInOrders < ActiveRecord::Migration
  def up
    rename_column :orders, :address, :street1
    add_column :orders, :street2, :string 
    add_column :orders, :email, :string
  end

  def down
    rename_column :orders, :street1, :address
    remove_column :orders, :street2    
    remove_column :orders, :email
  end
end
