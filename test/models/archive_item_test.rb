# == Schema Information
#
# Table name: archive_items
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  published   :boolean
#  hash_id     :string
#  date        :date
#  tags        :text
#  note        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ArchiveItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
