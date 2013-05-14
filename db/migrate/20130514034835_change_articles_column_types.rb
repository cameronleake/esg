class ChangeArticlesColumnTypes < ActiveRecord::Migration
  def up
    change_column :articles, :body, :text, :limit => nil
  end

  def down
    change_column :articles, :body, :string
  end
end
