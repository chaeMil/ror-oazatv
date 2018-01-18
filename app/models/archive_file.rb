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
end
