ActiveAdmin.register Category do
  menu :parent => "RESOURCES", :priority => 1
  scope :all, :default => true
  
  
  # Configuration for Sidebar Filters
  filter :name
  
  
  # Configuration for Categories Index Page  
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
    selectable_column
    column :name     
    default_actions                   
  end                                                      


  # Configuration for Categories Show Page
  show do |category|
    attributes_table do
      row :name
    end
    active_admin_comments
  end
    
  
  # Configuration for Categories Index Page
  form do |f|                         
    f.inputs "New Category" do       
      f.input :name
    end                               
    f.actions                         
  end
  
end
