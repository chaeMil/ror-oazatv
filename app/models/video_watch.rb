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
end
