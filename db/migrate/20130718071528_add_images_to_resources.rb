class AddImagesToResources < ActiveRecord::Migration
  
  def up
    rename_column :resources, :image, :image_1
    add_column :resources, :image_2, :string
    add_column :resources, :image_3, :string
  end   
  
  
  def down
    rename_column :resources, :image_1, :image
    remove_column :resources, :image_2
    remove_column :resources, :image_3
  end     
  
end
