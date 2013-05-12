# encoding: utf-8

class FeaturedImageUploader < CarrierWave::Uploader::Base

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
  # This is a sensible default for uploaders that are meant to be mounted:

  if ENV["RAILS_ENV"] == 'production'
    def store_dir
      "/home/deployer/apps/esg/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  elsif ENV["RAILS_ENV"] == 'development'
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # Generate Featured Image for Blog Post Blurb
  version :thumb do
    process :create_article_featured_image
  end
  
  def create_article_featured_image
    manipulate! do |img|
      img = img.resize_to_fit(740)
      img = img.crop(0, 0, 740, 160)
    end
  end

  # Generate Image for Blog Post Header
  version :header do
    process :create_article_header_image
  end
  
  def create_article_header_image
    manipulate! do |img|
      img = img.resize_to_fit(1200)
      img = img.crop(0, 0, 1200, 240)
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
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
