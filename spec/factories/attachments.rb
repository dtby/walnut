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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    content "MyString"
    content_file_name "MyString"
    content_content_type "MyString"
    content_file_size 1
    attachmentable_id 1
    attachmentable_type "MyString"
    file_url "MyString"
  end
end
