# == Schema Information
#
# Table name: task_categories
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  name        :string(255)
#  description :string(255)
#  unfinished  :integer          default(0)
#  total       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TaskCategory < ActiveRecord::Base
  belongs_to :project
  has_many :tasks, dependent: :destroy
  validates :name, presence: true
end
