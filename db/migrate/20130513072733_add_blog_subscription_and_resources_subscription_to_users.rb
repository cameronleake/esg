class AddBlogSubscriptionAndResourcesSubscriptionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blog_subscription, :boolean, :default => false
    add_column :users, :resources_subscription, :boolean, :default => false
  end
end
