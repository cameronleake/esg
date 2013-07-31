class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
