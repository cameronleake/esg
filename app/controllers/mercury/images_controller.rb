class Mercury::ImagesController < MercuryController

  respond_to :json
  
  def create
      @article_image = ArticleImage.new(params[:image])
      if params[:article_id]
        @current_article = Article.find(params[:article_id])
        @article_image.article = @current_article
      end
      @article_image.save!
      # render :json => @article_image.to_json(:only => :image)  THIS ALSO WORKS
      render text: "{\"image\":{\"url\":\"#{@article_image.image.url(:medium).to_s}\"}}"
   end

   def destroy
     @image = ArticleImage.find(params[:id])
     @image.destroy
     respond_with @image
   end

  # # POST /images.json
  # def create
  #   @image = Mercury::Image.new(params[:image])
  #   @image.save
  #   respond_with @image
  # end
  # 
  # # DELETE /images/1.json
  # def destroy
  #   @image = Mercury::Image.find(params[:id])
  #   @image.destroy
  #   respond_with @image
  # end

end
