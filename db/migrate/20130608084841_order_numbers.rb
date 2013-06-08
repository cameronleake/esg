class OrderNumbers < ActiveRecord::Migration
  def up   
    remove_column :shopping_carts, :email_sent   
    add_column :orders, :email_sent, :boolean, :default => false
    add_column :orders, :order_number, :integer
    remove_column :shopping_carts, :order_number  
  end

  def down                                      
    add_column :shopping_carts, :email_sent, :boolean, :default => false 
    remove_column :orders, :email_sent
    remove_column :orders, :order_number 
    add_column :shopping_carts, :order_number, :integer   
  end
end
