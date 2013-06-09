class ResourceImageUploader < CarrierWave::Uploader::Base
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
            
      
  # Generate Icon Resource Image for Shopping Cart
  version :icon do
    process :create_resource_image_icon
  end
  
  def create_resource_image_icon
    manipulate! do |img|
      img = img.resize_to_fill(100, 60)
      img = img.crop(Magick::CenterGravity, 100, 60)      
    end
  end


  # Generate Thumbnail Resource Image for Gallery
  version :thumb do
    process :create_resource_image_thumb
  end
  
  def create_resource_image_thumb
    manipulate! do |img|
      img = img.resize_to_fill(200, 130)
      img = img.crop(Magick::CenterGravity, 200, 130)      
    end
  end


  # Generate Large Resource Image for Preview
  version :preview do
    process :create_resource_image_preview
  end
  
  def create_resource_image_preview
    manipulate! do |img|
      img = img.resize_to_fit(600, 800)
    end
  end


  # Generate Header Resource Image
  version :medium do
    process :create_resource_image_medium
  end
  
  def create_resource_image_medium
    manipulate! do |img|
      img = img.resize_to_fill(200, 300)
      img = img.crop(Magick::CenterGravity, 200, 300)           
    end
  end
  
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
