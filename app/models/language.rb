# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  title      :text
#  locale     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Language < ApplicationRecord
end
