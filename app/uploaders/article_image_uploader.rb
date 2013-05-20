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
