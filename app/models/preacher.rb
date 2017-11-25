# == Schema Information
#
# Table name: preachers
#
#  id          :integer          not null, primary key
#  title       :text
#  tags        :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#

class Preacher < ApplicationRecord

  mount_uploader :image, PreacherUploader
  validates :title, presence: true
end
