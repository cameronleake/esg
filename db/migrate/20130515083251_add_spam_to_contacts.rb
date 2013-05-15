class AddSpamToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :spam, :boolean, :default => false
  end
end
