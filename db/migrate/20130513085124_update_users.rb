class UpdateUsers < ActiveRecord::Migration
  def up
    add_column :blog_comments, :user_id, :integer
    add_index :blog_comments, :user_id
  end

  def down
    remove_column :blog_comments, :user_id, :integer
    remove_index :blog_comments, :user_id
  end
end
