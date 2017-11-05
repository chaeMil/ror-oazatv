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
#
# Indexes
#
#  index_archive_files_on_archive_item_id  (archive_item_id)
#

class ArchiveFile < ApplicationRecord
  belongs_to :archive_item

  extend Enumerize
  mount_uploader :filename, ArchiveFileUploader

  TYPES = {
    undefined: 0,
    video: 1,
    audio: 2,
    image: 3,
    subtitles: 4
  }.freeze

  enumerize :file_type, in: {
    undefined: TYPES[:undefined],
    video: TYPES[:video],
    audio: TYPES[:audio],
    image: TYPES[:image],
    subtitles: TYPES[:subtitles]
  }
end
