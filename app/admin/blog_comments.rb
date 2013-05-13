ActiveAdmin.register BlogComment do
  menu :priority => 4
  menu :label => "Blog Comments"
  
  filter :article
  filter :user
  filter :created_at
  
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
    selectable_column                 
    column :article
    column :user
    column :created_at               
    default_actions                   
  end                                                      
  
end
