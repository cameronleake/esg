class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :body
      t.integer :rating
      t.integer :resource_id
      t.integer :user_id

      t.timestamps
    end
  end
end
