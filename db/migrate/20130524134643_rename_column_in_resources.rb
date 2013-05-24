class RenameColumnInResources < ActiveRecord::Migration
  def up
    rename_column :resources, :type, :price_type
  end

  def down
    rename_column :resources, :price_type, :type
  end
end
