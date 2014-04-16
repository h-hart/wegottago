# encoding: utf-8

class ThemeImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [600, 400]

  version :list do
    process :resize_to_fill => [485, 120]
  end

  version :list_small do
    process :resize_to_fill => [279, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png pjpeg)
  end

end
