class AddDefaultValueToUsersAvatar < ActiveRecord::Migration
  def change
    change_column :users, :avatar, :string, :default => ""
  end
end
