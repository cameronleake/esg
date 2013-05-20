class DropImageAndArticleIdFromArticleImages < ActiveRecord::Migration
  def up
    remove_column :article_images, :image
    remove_column :article_images, :article_id
  end

  def down
    add_column :article_images, :image, :string
    add_column :article_images, :article_id, :integer
  end
end
