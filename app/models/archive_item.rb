# == Schema Information
#
# Table name: archive_items
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  published   :boolean
#  hash        :string
#  date        :date
#  tags        :text
#  note        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ArchiveItem < ApplicationRecord
end
