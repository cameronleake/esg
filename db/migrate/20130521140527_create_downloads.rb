class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :link
      t.boolean :link_verified, :default => false
      t.datetime :expiry
      t.integer :resource_id
      t.integer :user_id

      t.timestamps
    end
  end
end
