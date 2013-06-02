class AddSpamToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :spam, :boolean, :default => false
  end
end
