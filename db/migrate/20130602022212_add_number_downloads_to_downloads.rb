class AddNumberDownloadsToDownloads < ActiveRecord::Migration
  def up
    add_column :downloads, :number_of_downloads, :integer, :default => 0
  end
  
  def down
    remove_column :downloads, :number_of_downloads
  end
end
