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
            
      
  # Generate Thumb Resource Image
  version :thumb do
    process :create_resource_image_thumb
  end
  
  def create_resource_image_thumb
    manipulate! do |img|
      img = img.resize_to_fill(200, 130)
      img = img.crop(Magick::CenterGravity, 200, 130)      
    end
  end


  # Generate Icon Resource Image
  version :icon do
    process :create_resource_image_icon
  end
  
  def create_resource_image_icon
    manipulate! do |img|
      img = img.resize_to_fill(150, 100)
      img = img.crop(Magick::CenterGravity, 150, 100)      
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
      img = img.resize_to_fill(240, 350)
      img = img.crop(Magick::CenterGravity, 240, 350)           
    end
  end
  
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
