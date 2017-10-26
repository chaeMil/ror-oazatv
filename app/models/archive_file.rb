# == Schema Information
#
# Table name: archive_files
#
#  id              :integer          not null, primary key
#  filename        :string
#  type            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  archive_item_id :integer
#
# Indexes
#
#  index_archive_files_on_archive_item_id  (archive_item_id)
#

class ArchiveFile < ApplicationRecord
  extend Enumerize

  enumerize :type, in: {:video => 1, :audio => 2, :image => 3, :subtitles => 4}

  belongs_to :archive_item
end
