# frozen_string_literal: true

# == Schema Information
#
# Table name: photo_albums
#
#  id          :integer          not null, primary key
#  published   :boolean
#  title       :text
#  description :text
#  tags        :text
#  date        :date
#  days        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PhotoAlbum < ApplicationRecord
  has_many :photos, inverse_of: :photo_album, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true
  validates :title, presence: true
  validates :date, presence: true
  translates :title, :description
  globalize_accessors :attributes => [:title, :description]
  globalize_validations locales: [:en]
end
