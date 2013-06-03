class RenameNumberOfDownloadsInDownloads < ActiveRecord::Migration
  def up
    rename_column :downloads, :number_of_downloads, :times_accessed
  end

  def down
    rename_column :downloads, :times_accessed, :number_of_downloads
  end
end
