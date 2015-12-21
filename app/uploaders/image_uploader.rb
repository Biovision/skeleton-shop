# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id/10000.floor}/#{model.id/100.floor}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path('fallback/image/' + [version_name, 'default.png'].compact.join('_'))
  end

  resize_to_fit 1080, 1080

  version :large do
    resize_to_fit 720, 720
  end

  version :medium do
    resize_to_fit 320, 320
  end

  version :preview, from_version: :medium do
    resize_to_fit 192, 192
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end
