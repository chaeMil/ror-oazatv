# == Schema Information
#
# Table name: video_convert_profiles
#
#  id                :integer          not null, primary key
#  title             :text
#  video_codec       :text
#  frame_rate        :float
#  resolution        :text
#  video_bitrate     :integer
#  audio_codec       :text
#  audio_bitrate     :integer
#  audio_sample_rate :integer
#  audio_channels    :integer
#  threads           :integer
#  custom            :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class VideoConvertProfile < ApplicationRecord
end
