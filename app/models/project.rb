class Project < ActiveRecord::Base

  has_many :task_categories, dependent: :destroy

  enum is_public: { open: true, close: false }
  IsPublic = { open: '公开', close: '私有' }

end
