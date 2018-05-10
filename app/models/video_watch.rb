# == Schema Information
#
# Table name: video_watches
#
#  id            :integer          not null, primary key
#  video_hash_id :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class VideoWatch < ApplicationRecord
  scope :popular_video_ids, -> {where('created_at >= ?', 1.week.ago)
                                    .group(:video_hash_id)
                                    .order('count_video_hash_id desc')
                                    .count(:video_hash_id)}
end
