# == Schema Information
#
# Table name: archive_items
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  published   :boolean
#  hash_id     :string
#  date        :date
#  tags        :text
#  note        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ArchiveItem < ApplicationRecord
  has_many :archive_files
  has_and_belongs_to_many :categories
  validates :title, presence: true
  validates :date, presence: true
end
