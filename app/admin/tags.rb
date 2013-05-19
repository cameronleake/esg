ActiveAdmin.register Tag do
  menu :parent => "ESG Blog"
  
  
  # Configuration for Tags Index Page
  config.sort_order = "name_asc"
  config.per_page = 15

  index do
    selectable_column
    column :name
    default_actions
  end
end
