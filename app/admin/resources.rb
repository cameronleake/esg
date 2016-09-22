# ActiveAdmin.register Resource do
#   menu :parent => "RESOURCES", :priority => 2 
#   scope :all, :default => true 
#   Category.all.each do |category|
#     scope "#{category.name.pluralize}" do |resource|
#       resource.where(:category_id => category.id)
#     end
#   end                         
#   
#   
#   # Configuration for Sidebar Filters   
#   filter :user
#   filter :category
#   filter :price_type, :as => :select, :collection => RESOURCE_PRICE_TYPES   
#   filter :name
#   filter :description
#   filter :price_in_cents
#   filter :number_of_downloads
# 
# 
#   # Configuration for Resources Index Page
#   config.sort_order = "id ASC"
#   config.per_page = 15
#   
#   index do
#    selectable_column
#    column :category
#    column :name
#    column "Price", :sortable => :price_in_cents do |resource|
#      div :class => "admin-center-column" do 
#        if resource.price_in_cents == 0
#          "Free"
#        else
#          "$" + number_with_precision(resource.price_in_cents.to_f/100, :precision => 2)
#        end
#      end
#    end  
#    column :number_of_downloads do |resource|
#      div :class => "admin-center-column" do 
#        resource.number_of_downloads
#      end     
#    end
#    default_actions
#   end
#   
#   
#   # Configuration for Resources Show Page
#   show do |resource|
#     attributes_table do
#       row :user
#       row :category
#       row :name
#       row :description
#       row :tag_list    
#       row :number_of_pages
#       row :price_type
#       if resource.price_type == "Paid"
#         row "Price" do
#            "$" + number_with_precision(resource.price_in_cents.to_f/100, :precision => 2)
#         end
#       end
#       row :number_of_downloads
#       row :file do |resource|
#         link_to "View File", resource.file_url if resource.file?
#       end
#       row "Preview Image 1" do |resource|
#         image_tag(resource.image_1.url(:preview)) if resource.image_1?
#       end
#       row "Preview Image 2" do |resource|
#         image_tag(resource.image_2.url(:preview)) if resource.image_2?
#       end
#       row "Preview Image 3" do |resource|
#         image_tag(resource.image_3.url(:preview)) if resource.image_3?
#       end      
#       row :created_at
#     end
#     active_admin_comments
#   end
#   
#    
#   # Configuration for Resources Edit Page
#   form do |f|                         
#    f.inputs "New Resource" do       
#      f.input :user, :as => :select, :collection => options_from_collection_for_select(User.all, :id, :email), :include_blank => false
#      f.input :category, :as => :select, :include_blank => false
#      f.input :name
#      f.input :description
#      f.input :price_type, :as => :select, :include_blank => false, :collection => RESOURCE_PRICE_TYPES
#      f.input :price_in_cents
#      f.input :tag_list
#      # f.input :tags, :as => :check_boxes, :multiple => true, :collection => @tags              # <TODO>
#      # f.input :tag_list, :as => :check_boxes, 
#      #   :collection => ActsAsTaggableOn::Tag.all.map(&:name)  
#      # f.input :tag_list, :as => :select,
#      #                    :multiple => :true,
#      #                    :collection => options_from_collection_for_select(Tag.all, :id, :name)      
#      # f.input :tag_list, :as => :check_boxes, :collection => Tag.all, :value_method => :name   
#      f.input :number_of_pages
#      f.input :file, :as => :file, :input_html => { :accept => "application/pdf" }, hint: resource.file_url
#      f.input :image_1, :as => :file, :input_html => { :accept => "image/*" }, hint: resource.image_1_url
#      f.input :image_2, :as => :file, :input_html => { :accept => "image/*" }, hint: resource.image_2_url     
#      f.input :image_3, :as => :file, :input_html => { :accept => "image/*" }, hint: resource.image_3_url          
#    end                               
#    f.actions                         
#   end   
#   
# end  