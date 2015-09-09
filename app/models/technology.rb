class Technology < ActiveRecord::Base
	has_one :image, as: :imageable, dependent: :destroy

	has_many :technology_stages
end
