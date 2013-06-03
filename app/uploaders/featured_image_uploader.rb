class FeaturedImageUploader < CarrierWave::Uploader::Base
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


  # Generate Featured Image for Blog Post Blurb
  version :thumb do
    process :create_article_featured_image
  end
  
  def create_article_featured_image
    manipulate! do |img|
      img = img.resize_to_fill(200, 130)
      img = img.crop(Magick::CenterGravity, 200, 130)
    end
  end


  # Generate Image for Blog Post Header
  version :header do
    process :create_article_header_image
  end
  
  def create_article_header_image
    manipulate! do |img|
      img = img.resize_to_fit(1200)
      img = img.crop(Magick::CenterGravity, 1200, 240)
    end
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
