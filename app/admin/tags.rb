ActiveAdmin.register Tag do
  menu :parent => "CONFIG", :priority => 1
  
  
  # Configuration for Tags Index Page
  config.sort_order = "name_asc"
  config.per_page = 15

  index do
    selectable_column
    column :name
    default_actions
  end
  
  
  # Configuration for Tags Show Page
  show do |tags|
    attributes_table do
      row :name
    end
    active_admin_comments
  end
  
end
