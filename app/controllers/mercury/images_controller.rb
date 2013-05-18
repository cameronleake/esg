class Mercury::ImagesController < MercuryController

  respond_to :json
  
  def create
      @article_image = ArticleImage.new(params[:image])
      # @current_article = Article.find(params[:article_id])
      # @article_image.article = @current_article
      @article_image.save!
      ## Needs to send link to the resized image: @article_image.article_image.image.url(:medium)
      render :json => @article_image.to_json(:only => :image)
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
