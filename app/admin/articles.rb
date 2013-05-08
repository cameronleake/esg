ActiveAdmin.register Article do
  menu :priority => 2
       
  filter :title
  filter :body
  filter :created_at   
  filter :updated_at
  
  config.sort_order = "created_at_desc"
  config.per_page = 15

  index do
    selectable_column
    column :title
    column :body
    column :created_at
    column :updated_at
    default_actions
  end
  
  form do |f|                         
    f.inputs "New Article" do       
      f.input :title              
      f.input :body, as: :text        
    end                               
    f.actions                         
  end
  
end