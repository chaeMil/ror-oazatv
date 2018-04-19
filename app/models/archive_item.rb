# == Schema Information
#
# Table name: archive_items
#
#  id         :integer          not null, primary key
#  published  :boolean
#  hash_id    :string
#  date       :date
#  tags       :text
#  note       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArchiveItem < ApplicationRecord
  has_many :archive_files, inverse_of: :archive_item, dependent: :destroy
  has_and_belongs_to_many :categories
  validates :title, presence: true
  validates :date, presence: true
  translates :title, :description
  globalize_accessors attributes: [:title, :description]
  globalize_validations locales: [:en]

  def get_thumbnail(locale)
    thumb_url = nil
    thumb_url_fallback = nil
    archive_files.each do |archive_file|
      if archive_file.image? && archive_file.language.locale == locale.to_s
        thumb_url = archive_file.file.medium.url
      elsif archive_file.image?
        thumb_url_fallback = archive_file.file.medium.url
      end
    end
    if thumb_url != nil
      thumb_url
    else
      thumb_url_fallback
    end
  end
end
