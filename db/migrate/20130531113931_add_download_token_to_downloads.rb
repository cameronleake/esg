class AddDownloadTokenToDownloads < ActiveRecord::Migration
  def up
    add_column :downloads, :download_token, :string
  end
  
  def down
    remove_column :downloads, :download_token
  end
end
