class ArchiveFileService

  def self.upload_file(archive_item_id, file, filetype)
    case filetype
      when ArchiveFile::TYPES[:image]
        upload_image_file(archive_item_id, file)
    end
  end

  def self.generate_file_name(file)
    "#{SecureRandom.hex(8)}#{File.extname(file.original_filename)}"
  end

  def self.upload_image_file(archive_item_id, file)
    #filename = generate_file_name(file)
    uploader = ArchiveFileImageUploader.new
    #p filename
    #p archive_item_id
  end
end