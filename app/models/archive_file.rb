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

  def convert(video_convert_progress_id, convert_profile_id)
    if video?
      convert_profile = VideoConvertProfile.find(convert_profile_id)
      video = FFMPEG::Movie.new(file.path)

      new_video_filename = "#{SecureRandom.hex(6)}.#{convert_profile['extension']}"
      new_archive_file = ArchiveFile.new(archive_item: archive_item,
                                         language: language,
                                         file_type: file_type)
      new_archive_file.save

      update_filename = "UPDATE archive_files SET file='#{new_video_filename}' WHERE id = #{new_archive_file.id}"
      ActiveRecord::Base.connection.execute(update_filename)

      video_convert_progress = VideoConvertProgress.find(video_convert_progress_id)
      video_convert_progress.update(archive_file_id: id, started_at: DateTime.now)

      options = {
          video_codec: convert_profile['video_codec'],
          frame_rate: convert_profile['frame_rate'],
          resolution: convert_profile['resolution'],
          video_bitrate: convert_profile['video_bitrate'],
          audio_codec: convert_profile['audio_codec'],
          audio_bitrate: convert_profile['audio_bitrate'],
          audio_sample_rate: convert_profile['audio_sample_rate'],
          audio_channels: convert_profile['audio_channels'],
          threads: convert_profile['threads']
      }
      video.transcode("#{File.dirname(file.path)}/#{new_video_filename}", options) do |progress|
        video_convert_progress.update(progress: progress,
                                      status: VideoConvertProgress.status.find_value(:processing).value)
        if progress == 1.0
          video_convert_progress.update(finished_at: DateTime.now,
                                        status: VideoConvertProgress.status.find_value(:done).value)
        end
        p progress
      end
    else
      throw 'File is not a video! Cannot convert'
    end
  end
end
