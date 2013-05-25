class ChangeDownloadsInResources < ActiveRecord::Migration
  def up
    change_column :resources, :number_of_downloads, :integer, :default => 0
  end

  def down
    change_column :resources, :number_of_downloads, :integer, :default => nil    
  end
end
