class AddDistributedAtToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :distributed_at, :datetime
  end
end
