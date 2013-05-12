ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

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
        panel "Recent Articles" do
          table_for Article.last(5).reverse do
            column ("description") {|article| link_to(article.title, admin_article_path(article)) } 
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
            column :created_at
          end
          strong { link_to "View All Contact Tickets", admin_contacts_path }
        end
      end
      
      column do
        panel "Recent Blog Comments" do
          table_for BlogComment.last(5).reverse do
            column ("article") {|blog_comment| link_to(blog_comment.article.title, admin_blog_comment_path(blog_comment)) } 
            column :commenter
          end
          strong { link_to "View All Blog Comments", admin_blog_comments_path }
        end
      end
    end
  end
end
