class Image < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	has_attached_file :avatar, :styles => {
  	                                    :t_98 => "98x98", #教师头像
  	                                    },
  	                         :default_url => "/images/missing/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
