# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  is_public   :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ActiveRecord::Base

  has_many :task_categories, dependent: :destroy

  enum is_public: { open: true, close: false }
  IsPublic = { open: '公开', close: '私有' }

end
