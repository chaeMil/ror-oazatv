class ArchiveFileService
  def self.get_video_info(file_path)
    FFMPEG::Movie.new(file_path)
  end
end