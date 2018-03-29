# == Schema Information
#
# Table name: video_convert_progresses
#
#  id                          :integer          not null, primary key
#  progress                    :float
#  status                      :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  finished_at                 :datetime
#  archive_file_id             :integer
#  started_at                  :datetime
#  error                       :text
#  original_archive_file_id_id :integer
#  original_archive_file_id    :integer
#
# Indexes
#
#  index_video_convert_progresses_on_original_archive_file_id     (original_archive_file_id)
#

class VideoConvertProgress < ApplicationRecord
  extend Enumerize

  belongs_to :archive_file, optional: true

  enumerize :status, in: {
      waiting: 0,
      processing: 1,
      done: 2,
      error: 3,
  }, default: 0
end
