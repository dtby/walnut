# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    avatar_file_name "MyString"
    avatar_content_type "MyString"
    avatar_file_size 1
    imageable_id 1
    imageable_type "MyString"
  end
end
