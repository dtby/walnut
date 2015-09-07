class Train < ActiveRecord::Base
	acts_as_views_count
	
	has_one :image, as: :imageable, dependent: :destroy
end
