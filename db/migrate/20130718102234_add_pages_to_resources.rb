class AddPagesToResources < ActiveRecord::Migration
  def change
    add_column :resources, :number_of_pages, :integer
  end
end
