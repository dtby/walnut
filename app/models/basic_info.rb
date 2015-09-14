class BasicInfo < ActiveRecord::Base
	has_one :image, as: :imageable, dependent: :destroy
	belongs_to :user
end
