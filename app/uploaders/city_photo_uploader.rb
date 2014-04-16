# encoding: utf-8

class CityPhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fill => [1400, 350]

  def extension_white_list
    %w(jpg jpeg gif png pjpeg)
  end

  def default_url
    "/assets/default_city.jpg"
  end

end