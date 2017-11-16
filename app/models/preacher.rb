# == Schema Information
#
# Table name: preachers
#
#  id          :integer          not null, primary key
#  title       :text
#  tags        :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Preacher < ApplicationRecord
end
