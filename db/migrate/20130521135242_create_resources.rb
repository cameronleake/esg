class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :description
      t.string :type
      t.integer :price
      t.string :image
      t.string :file
      t.string :category
      t.integer :number_of_downloads
      t.integer :user_id

      t.timestamps
    end
  end
end
