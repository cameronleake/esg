# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
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

  # Whitelist for file types allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  
    "/assets/fallback/" + [version_name, "Default_Profile_Icon.jpg"].compact.join('_')
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
