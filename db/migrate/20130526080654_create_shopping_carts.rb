class CreateShoppingCarts < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.integer :user_id
      t.boolean :payment_verified, :default => false
      t.boolean :email_sent, :default => false

      t.timestamps
    end
  end
end
