class ChangeColumnInResources < ActiveRecord::Migration
  def up
    remove_column :resources, :category
    add_column :resources, :category_id, :integer
  end

  def down
    remove_column :resources, :category_id
    add_column :resources, :category, :string
  end
end
