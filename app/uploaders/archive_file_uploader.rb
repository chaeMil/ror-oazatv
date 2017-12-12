class ArchiveFileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/videos/#{model.archive_item_id}/"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  version :thumb, if: :image? do
    process resize_to_fill: [256, 256]
  end

  version :thumb_big, if: :image? do
    process resize_to_fill: [512, 512]
  end

  version :tiny, if: :image? do
    process resize_to_fit: [256, 256]
  end

  version :small, if: :image? do
    process resize_to_fit: [512, 512]
  end

  version :medium, if: :image? do
    process resize_to_fit: [1024, 1024]
  end

  version :big, if: :image? do
    process resize_to_fit: [2048, 2048]
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(6))
  end

  private
  def image?(new_file)
    new_file.content_type.include? 'image'
  end

end
