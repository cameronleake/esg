class AddFeaturedResourceToResources < ActiveRecord::Migration
  def change
    add_column :resources, :featured_resource, :boolean, :default => false
  end
end
