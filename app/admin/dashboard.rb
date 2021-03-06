ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => "DASHBOARD"

  content :title => "Engineering Survival Guide" do

    columns do
      column do
        div :class => "admin-center-column" do         
          panel "Registered Users" do
            h1 User.find(:all).count
          end
        end
      end

      column do
        div :class => "admin-center-column" do         
          panel "Total Blog Articles" do
            h1 Article.find(:all).count
          end
        end
      end

      column do
        div :class => "admin-center-column" do         
          panel "Total Resources" do
            h1 Resource.find(:all).count
          end
        end
      end

      column do
        div :class => "admin-center-column" do 
          panel "Open Contact Tickets" do
            h1 Contact.where(:status => "OPEN").count
          end
        end
      end
    
      column do
        div :class => "admin-center-column" do 
          panel "Spam Comments" do
            h1 BlogComment.where(:spam => true).count
          end
        end
      end
      
      column do
        div :class => "admin-center-column" do 
          panel "Spam Reviews" do
            h1 Review.where(:spam => true).count
          end
        end
      end
    end

    columns do
      column do
        panel "Total Users" do
          render "user_signup_graph"
          strong { link_to "View All Users", admin_users_path }
        end
      end  
      
      column do
        panel "Total Resource Downloads" do
          render "download_quantity_graph"
          strong { link_to "View All Resources", admin_resources_path }
        end
      end
    end
    
    columns do
      column do
        panel "Popular Resources" do
          table_for Resource.order("number_of_downloads DESC").limit(5) do
            column ("Resource") {|resource| link_to(resource.name, admin_resource_path(resource)) } 
            column :number_of_downloads
          end
          strong { link_to "View All Resources", admin_resources_path }
        end
      end
      
      column do
        panel "Articles Not Yet Distibuted - (via Email)" do
          table_for Article.where(:distributed_at => nil) do
            column ("Article") {|article| link_to(article.title, admin_article_path(article)) } 
            column :created_at
          end
          strong { link_to "View All Articles", admin_articles_path }
        end
      end
    end

    columns do
      column do
        panel "Recent Users" do
          table_for User.last(5).reverse do
            column ("email") {|user| link_to(user.email, admin_user_path(user)) } 
            column :created_at
          end
          strong { link_to "View All Users", admin_users_path }
        end
      end

      column do
        panel "Draft Articles - (Not Yet Published to Blog)" do
          table_for Article.where(:published => false) do
            column ("Article") {|article| link_to(article.title, admin_article_path(article)) } 
            column :created_at
          end
          strong { link_to "View All Articles", admin_articles_path }
        end
      end
    end
    
    columns do
      column do
        panel "Recent Contact Tickets" do
          table_for Contact.last(5).reverse do
            column ("subject") {|contact| link_to(contact.subject, admin_contact_path(contact)) } 
            column :status
            column :created_at
          end
          strong { link_to "View All Contact Tickets", admin_contacts_path }
        end
      end
      
       column do
        panel "Recent Blog Comments" do
          table_for BlogComment.where(:spam => false).last(5).reverse do
            column ("article") {|blog_comment| link_to(blog_comment.article.title, admin_blog_comment_path(blog_comment)) } 
            column :user
          end
          strong { link_to "View All Blog Comments", admin_blog_comments_path }
        end
      end
    end
   
    columns do 
      column do
        panel "Recent Spam Blog Comments" do
          table_for BlogComment.where(:spam => true).last(5).reverse do
            column ("article") {|blog_comment| link_to(blog_comment.article.title, admin_blog_comment_path(blog_comment)) } 
            column :user
          end
          strong { link_to "View All Blog Comments", admin_blog_comments_path }
        end
      end
      
      column do
        panel "Recent Spam Resource Reviews" do
          table_for Review.where(:spam => true).last(5).reverse do
            column ("Review") {|review| link_to(review.title, admin_review_path(review)) } 
            column :user
          end
          strong { link_to "View All Resource Reviews", admin_reviews_path }
        end
      end
      
    end
  end
end
