class AddFeaturedImageToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :featured_image, :string
  end
end
