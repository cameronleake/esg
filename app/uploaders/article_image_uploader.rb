# encoding: utf-8

class ArticleImageUploader < CarrierWave::Uploader::Base

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
  
  # Generate Medium Article Image for User
  version :medium do
    process :create_article_medium_image
  end

  def create_article_medium_image
    manipulate! do |img|
      img = img.resize_to_fit(300, 300)
      img = img.crop(Magick::CenterGravity, 300, 300)
    end
  end

  # Generate Admin Thumbnail Article Image for User
  version :thumb do
    process :create_article_thumb_image
  end

  def create_article_thumb_image
    manipulate! do |img|
      img = img.resize_to_fit(120, 120)
      img = img.crop(Magick::CenterGravity, 120, 120)
    end
  end

  # Whitelist for file types allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end