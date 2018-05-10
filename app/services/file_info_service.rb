class FileInfoService
  def self.get_video_info(archive_file)
    if archive_file.video?
      if File::exist?(archive_file.file.path)
        FFMPEG::Movie.new(archive_file.file.path)
      else
        'File does not exist! Cannot get video info'
      end
    else
      'File is not a video! Cannot get video info'
    end
  end

  def self.get_image_info(archive_file)
    if archive_file.image?
      require 'exifr/jpeg'
      EXIFR::JPEG.new(archive_file.file.path)
    else
      'File is not a image! Cannot get image info'
    end
  end

  def self.get_subtitles_info(archive_file)
    if archive_file.subtitles?
      data = File.read(archive_file.file.path)
      filesize = File.size(archive_file.file.path)
      info = {
          data: data,
          filesize: filesize
      }
      info
    else
      'File is not a subtitles! Cannot get subtitles info'
    end
  end
end