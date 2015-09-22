class Profession < ActiveRecord::Base
	validates :name, :introduce, presence: true
	
	has_one :image, as: :imageable, dependent: :destroy

	has_many :profession_stages, dependent: :destroy
end
