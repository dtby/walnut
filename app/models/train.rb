class Train < ActiveRecord::Base
	acts_as_views_count
	
	has_one :image, as: :imageable, dependent: :destroy

	has_many :user_trains, dependent: :destroy
  	has_many :users, through: :user_trains

end
