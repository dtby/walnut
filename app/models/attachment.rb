# == Schema Information
#
# Table name: attachments
#
#  id                   :integer          not null, primary key
#  content              :string(255)
#  content_file_name    :string(255)
#  content_content_type :string(255)
#  content_file_size    :integer
#  attachmentable_id    :integer
#  attachmentable_type  :string(255)
#  file_url             :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  sub_course_id        :integer
#

class Attachment < ActiveRecord::Base
	belongs_to :attachmentable, polymorphic: true
	has_attached_file :content
	validates_attachment :content, :content_type => {:content_type => %w()}
end
