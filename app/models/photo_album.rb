# == Schema Information
#
# Table name: photo_albums
#
#  id          :integer          not null, primary key
#  published   :boolean
#  title       :text
#  description :text
#  tags        :text
#  date        :date
#  days        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PhotoAlbum < ApplicationRecord
end
