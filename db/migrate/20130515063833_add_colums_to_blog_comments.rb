class AddColumsToBlogComments < ActiveRecord::Migration
  def change
    add_column :blog_comments, :spam, :boolean, :default => false
  end
end
