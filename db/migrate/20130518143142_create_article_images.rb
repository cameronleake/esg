class CreateArticleImages < ActiveRecord::Migration
  def change
    create_table :article_images do |t|
      t.string :image
      t.integer :article_id

      t.timestamps
    end
  end
end
