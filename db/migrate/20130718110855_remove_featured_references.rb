class RemoveFeaturedReferences < ActiveRecord::Migration
  def up
    remove_column :articles, :featured_article
    remove_column :resources, :featured_resource
  end

  def down                    
    add_column :articles, :featured_article, :boolean, :default => false
    add_column :resources, :featured_resource, :boolean, :default => false
  end
end
