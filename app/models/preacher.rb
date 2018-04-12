# == Schema Information
#
# Table name: preachers
#
#  id         :integer          not null, primary key
#  title      :text
#  tags       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image      :string
#

class Preacher < ApplicationRecord

  translates :description
  mount_uploader :image, PreacherUploader
  validates :title, presence: true
  globalize_accessors attributes: [:description]
  globalize_validations locales: [:en]
end
