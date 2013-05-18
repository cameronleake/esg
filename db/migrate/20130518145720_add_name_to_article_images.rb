class AddNameToArticleImages < ActiveRecord::Migration
  def change
    add_column :article_images, :name, :string
  end
end
