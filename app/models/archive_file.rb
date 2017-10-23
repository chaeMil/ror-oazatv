# == Schema Information
#
# Table name: archive_files
#
#  id         :integer          not null, primary key
#  filename   :string
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArchiveFile < ApplicationRecord
end
