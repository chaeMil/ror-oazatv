# == Schema Information
#
# Table name: photos
#
#  id               :integer          not null, primary key
#  photo_album_id   :integer
#  description      :text
#  order            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  image            :string
#  image_processing :boolean          default(FALSE), not null
#
# Indexes
#
#  index_photos_on_photo_album_id  (photo_album_id)
#

class Photo < ApplicationRecord
  belongs_to :photo_album
  validates :photo_album, presence: true
  mount_uploader :image, PhotoUploader
  process_in_background :image
end
