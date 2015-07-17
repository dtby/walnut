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

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
