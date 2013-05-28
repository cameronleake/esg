class ChangeColumnInDownloads < ActiveRecord::Migration
  def up
    rename_column :downloads, :link_verified, :link_valid
    rename_column :downloads, :expiry, :expiry_time
  end

  def down
    rename_column :downloads, :link_valid, :link_verified
    rename_column :downloads, :expiry_time, :expiry
  end
end
