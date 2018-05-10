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
#  views      :integer
#

class ArchiveItem < ApplicationRecord
  has_many :archive_files, inverse_of: :archive_item, dependent: :destroy
  has_and_belongs_to_many :categories
  validates :title, presence: true
  validates :date, presence: true
  translates :title, :description
  globalize_accessors attributes: [:title, :description]
  globalize_validations locales: [:en]

  scope :by_title, ->(title) {joins(:translations).where('lower(archive_item_translations.title) LIKE ?', "%#{title.to_s.downcase}%").distinct}
  scope :by_category, ->(category) { includes(:categories).where(categories: {id: category.id})}

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
    if !thumb_url.nil?
      thumb_url
    else
      thumb_url_fallback
    end
  end

  def get_video_sources(locale)
    sources = []
    archive_files.each do |archive_file|
      if !locale.nil?
        if archive_file.video? && archive_file.language.locale == locale.to_s
          sources.push(archive_file)
        end
      elsif archive_file.video?
        sources.push(archive_file)
      end
    end
    sources
  end

  def get_subtitle_sources(locale)
    sources = []
    archive_files.each do |archive_file|
      if !locale.nil?
        if archive_file.subtitles? && archive_file.language.locale == locale.to_s
          sources.push(archive_file)
        end
      elsif archive_file.subtitles?
        sources.push(archive_file)
      end
    end
    sources
  end

  def get_audio_sources(locale)
    sources = []
    archive_files.each do |archive_file|
      if !locale.nil?
        if archive_file.audio? && archive_file.language.locale == locale.to_s
          sources.push(archive_file)
        end
      elsif archive_file.audio?
        sources.push(archive_file)
      end
    end
    sources
  end
end
