class Technology < ActiveRecord::Base
	validates :name, :introduce, presence: true
	
	has_one :image, as: :imageable, dependent: :destroy

	has_many :technology_stages, dependent: :destroy
end
