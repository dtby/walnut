# == Schema Information
#
# Table name: images
#
#  id                  :integer          not null, primary key
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  imageable_id        :integer
#  imageable_type      :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Image < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	has_attached_file :avatar, :styles => {
  	                                    :t_98 => "98x98", #教师头像
  	                                    :c_460_350 => "460x350",  #课程详情页图片
  	                                    :c_360_200 => "360x200",  #课程列表页图片
  	                                    :c_250_190 => "250x190",  #子课程列表页图片
  	                                    :c_130_70 => "130x70",  #子课程列表页小图图片
                                        :u_202_202 => '202x202'
  	                                    },
  	                         :default_url => "/images/missing/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
