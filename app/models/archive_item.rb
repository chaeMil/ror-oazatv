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
end
