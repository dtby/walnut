class UserAnnounce < ActiveRecord::Base
  belongs_to :user
  belongs_to :announce
end
