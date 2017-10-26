class ArchiveFileService

  def self.upload_file(params)
    case params[:file_type]
      when ArchiveFile::TYPES[:image]
        upload_image_file(params)
    end
  end

  def upload_image_file(params)
    p params
  end
end