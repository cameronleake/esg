class ArticleImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file


  # File Storage Configuration
  CarrierWave.configure do |config|
    if Rails.env.production?
      config.root = "/home/deployer/apps/esg/shared/"
      def store_dir
        "assets/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    elsif Rails.env.development?
      config.root = "#{Rails.root}/public"
      def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
  
  
  # Generate Small Article Image
  version :small do
    process :create_article_image_small
  end

  def create_article_image_small
    manipulate! do |img|
      img = img.resize_to_fit(150, 150)
    end
  end


  # Generate Medium Article Image
  version :medium do
    process :create_article_image_medium
  end

  def create_article_image_medium
    manipulate! do |img|
      img = img.resize_to_fit(300, 300)
    end
  end
  
  
  # Generate Large Article Image
  version :large do
    process :create_article_image_large
  end

  def create_article_image_large
    manipulate! do |img|
      img = img.resize_to_fit(500, 500)
    end
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
