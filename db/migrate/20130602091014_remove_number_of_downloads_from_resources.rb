class RemoveNumberOfDownloadsFromResources < ActiveRecord::Migration
  def up
    remove_column :resources, :number_of_downloads
  end

  def down
    add_column :resources, :number_of_downloads, :integer, :default => 0
  end
end
