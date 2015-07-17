# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  view_count  :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  teacher_id  :integer
#  college_id  :integer
#  category_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    title "MyString"
    description "MyText"
    view_count 1
  end
end
