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
    end
    
    columns do
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

  end
end
