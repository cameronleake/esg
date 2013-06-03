class AvatarUploader < CarrierWave::Uploader::Base
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


  # Generate Avatar Image for User
  version :avatar do
    process :create_user_avatar_image
  end

  def create_user_avatar_image
    manipulate! do |img|
      img = img.resize_to_fit(64, 64)
    end
  end


  # Generate Profile Image for User
  version :profile do
    process :create_user_profile_image
  end
  
  def create_user_profile_image
    manipulate! do |img|
      img = img.resize_to_fit(200, 200)
    end
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end


  # Default URL for if there hasn't been a file uploaded
  def default_url
    "/assets/fallback/" + [version_name, "Default_Profile_Icon.jpg"].compact.join('_')
  end

end
