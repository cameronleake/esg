class AddSearchIndexToArticles < ActiveRecord::Migration

  def up
    execute "create index articles_title on articles using gin(to_tsvector('english', title))"
    execute "create index articles_body on articles using gin(to_tsvector('english', body))"
  end

  def down
    execute "drop index articles_title"
    execute "drop index articles_body"
  end

end
