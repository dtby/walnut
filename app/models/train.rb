class Train < ActiveRecord::Base
	has_attached_file :picture_url, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/workt1.png"
  	
	validates_attachment_content_type :picture_url, content_type: /\Aimage\/.*\Z/
end
