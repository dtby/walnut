# == Schema Information
#
# Table name: degrees
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  sort_no    :integer          default(1000)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :degree do
    name "MyString"
    sort_no 1
  end
end
