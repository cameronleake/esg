class AddNumberOfDownloadsToResources < ActiveRecord::Migration
  def change
    add_column :resources, :number_of_downloads, :integer, :default => 0
  end
end
