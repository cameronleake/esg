class CreateBlogComments < ActiveRecord::Migration
  def change
    create_table :blog_comments do |t|
      t.string :commenter
      t.text :body
      t.references :article

      t.timestamps
    end
    add_index :blog_comments, :article_id
  end
end
