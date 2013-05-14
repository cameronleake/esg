class AddFeaturedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :featured_article, :boolean, :default => false
  end
end
