class ChangeColumnsInDownlaods < ActiveRecord::Migration
  def up
    remove_column :downloads, :link
    rename_column :downloads, :link_valid, :link_expired
    change_column :downloads, :link_expired, :boolean, :default => false
  end

  def down
    add_column :downloads, :link, :string
    rename_column :downloads, :link_expired, :link_valid
  end
end
