class RemoveTitleFromReviews < ActiveRecord::Migration
  def up
    remove_column :reviews, :title
  end

  def down
    add_column :reviews, :title, :string
  end
end
