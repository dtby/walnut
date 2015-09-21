class Profession < ActiveRecord::Base
	has_one :image, as: :imageable, dependent: :destroy

	has_many :profession_stages, dependent: :destroy
end
