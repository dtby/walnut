class College < ActiveRecord::Base
	has_one :image, as: :imageable, dependent: :destroy
	has_many :courses, dependent: :destroy
end
