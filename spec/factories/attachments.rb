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
