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
