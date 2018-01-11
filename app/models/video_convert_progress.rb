# == Schema Information
#
# Table name: video_convert_progresses
#
#  id              :integer          not null, primary key
#  progress        :float
#  status          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  finished_at     :datetime
#  archive_file_id :integer
#  started_at      :datetime
#  error           :text
#

class VideoConvertProgress < ApplicationRecord
  extend Enumerize

  enumerize :status, in: {
      waiting: 0,
      processing: 1,
      done: 2,
      error: 3,
  }, default: 0
end
