# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  project_id :integer
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notification < ActiveRecord::Base
  belongs_to :project
end
