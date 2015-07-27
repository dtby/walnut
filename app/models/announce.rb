# == Schema Information
#
# Table name: announces
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Announce < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :title, :description, :user_id, :project_id, presence: true
end
