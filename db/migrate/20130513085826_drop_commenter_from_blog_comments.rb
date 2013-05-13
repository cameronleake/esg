class DropCommenterFromBlogComments < ActiveRecord::Migration
  def up
    remove_column :blog_comments, :commenter
  end

  def down
    add_column :blog_comments, :commenter, :string
  end
end
