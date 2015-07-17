# == Schema Information
#
# Table name: sub_courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sub_course do
    title "MyString"
    description "MyText"
  end
end
