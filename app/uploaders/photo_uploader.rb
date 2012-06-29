# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  storage :fog

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  process :resize_to_fill => [800, 600]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :petit do
    process :resize_to_fill => [120, 90]
  end

  version :thumb do
    process :resize_to_fill => [240, 180]
  end

  version :medium do
    process :resize_to_fill => [320, 240]
  end

  version :profile do
    process :resize_to_fill => [300, 350]
  end

  version :big do
    process :resize_to_fill => [612, 612]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
