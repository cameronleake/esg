ActiveAdmin.register BlogComment do
  menu :priority => 4
  menu :label => "Blog Comments"
  
  filter :commenter
  filter :article
  filter :created_at
  
  config.sort_order = "created_at_desc"
  config.per_page = 15
  
  index do
    selectable_column
    column :commenter                         
    column :article
    column :created_at               
    default_actions                   
  end                                                      
  
end
