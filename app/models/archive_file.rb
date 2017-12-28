# == Schema Information
#
# Table name: archive_files
#
#  id              :integer          not null, primary key
#  file            :string
#  file_type       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  archive_item_id :integer
#  language_id     :integer
#
# Indexes
#
#  index_archive_files_on_archive_item_id  (archive_item_id)
#  index_archive_files_on_language_id      (language_id)
#

class ArchiveFile < ApplicationRecord
  belongs_to :archive_item
  belongs_to :language
  mount_uploader :file, ArchiveFileUploader

  extend Enumerize

  enumerize :file_type, in: {
      undefined: 0,
      video: 1,
      audio: 2,
      image: 3,
      subtitles: 4
  }, default: 0

  def video?
    file_type == :video
  end

  def image?
    file_type == :image
  end

  def audio?
    file_type == :audio
  end

  def subtitles?
    file_type == :subtitles
  end

  def get_video_info
    if video?
      FFMPEG::Movie.new(file.path)
    else
      throw 'File is not a video! Cannot get video info'
    end
  end

  def convert(video_convert_progress_id)
    if video?
      video = FFMPEG::Movie.new(file.path)
      new_video_filename = SecureRandom.hex(6)
      video_convert_progress = VideoConvertProgress.find(video_convert_progress_id)
      video_convert_progress.update(archive_file_id: id)
      video.transcode("#{File.dirname(file.path)}/#{new_video_filename}.mkv") do |progress|
        video_convert_progress.update(progress: progress, status: VideoConvertProgress.status.find_value(:processing).value)
        video_convert_progress.update(finished_at: DateTime.now, status: VideoConvertProgress.status.find_value(:done).value) if progress == 1.0
        p progress
      end
    else
      throw 'File is not a video! Cannot convert'
    end
  end
end
