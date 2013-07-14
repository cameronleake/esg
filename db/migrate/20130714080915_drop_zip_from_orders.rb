class DropZipFromOrders < ActiveRecord::Migration
  def up    
    remove_column :orders, :zip
  end

  def down                     
    add_column :orders, :zip, :string
  end
end
