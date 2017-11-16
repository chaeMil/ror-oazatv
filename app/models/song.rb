# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  title      :text
#  tag        :text
#  author     :text
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Song < ApplicationRecord
end
