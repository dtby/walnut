# == Schema Information
#
# Table name: teachers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(65535)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teacher do
    name "MyString"
    description "MyText"
    deleted_at "2015-07-16 15:57:57"
  end
end
