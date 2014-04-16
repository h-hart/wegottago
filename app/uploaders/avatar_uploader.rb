# encoding: utf-8
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fit => [455, 0]

  version :thumb do
    process :manualcrop
    process :resize_to_fill => [200, 200]
  end

  def default_url
    "/assets/default_avatar.png"
  end

  def default?
    url == "/assets/default_avatar.png"
  end

  def extension_white_list
    %w(jpg jpeg gif png pjpeg)
  end

  def manualcrop
    manipulate! do |img| 
      img = img.crop(model.crop_x.to_i,model.crop_y.to_i,model.crop_h.to_i,model.crop_w.to_i)
    end
  end

end
