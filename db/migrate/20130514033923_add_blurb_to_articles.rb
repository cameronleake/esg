class AddBlurbToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :blurb, :string
  end
end
