# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  color      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  has_and_belongs_to_many :archive_items
  validates :title, presence: true
  validates :color, presence: true
  translates :title
  globalize_accessors :attributes => [:title]
  globalize_validations locales: [:en]
end
