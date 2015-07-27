class ProjectAnnounce < ActiveRecord::Base
  belongs_to :project
  belongs_to :announce
end
