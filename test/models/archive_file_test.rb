# == Schema Information
#
# Table name: archive_files
#
#  id              :integer          not null, primary key
#  file            :string
#  file_type       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  archive_item_id :integer
#  language_id     :integer
#
# Indexes
#
#  index_archive_files_on_archive_item_id  (archive_item_id)
#

require 'test_helper'

class ArchiveFileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
