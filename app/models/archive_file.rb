# == Schema Information
#
# Table name: archive_files
#
#  id              :integer          not null, primary key
#  filename        :string
#  type            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  archive_item_id :integer
#
# Indexes
#
#  index_archive_files_on_archive_item_id  (archive_item_id)
#

class ArchiveFile < ApplicationRecord
  belongs_to :archive_item
end
