class AddTopicToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :topic, :string
  end
end
