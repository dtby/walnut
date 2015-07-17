# == Schema Information
#
# Table name: sms
#
#  id         :integer          not null, primary key
#  mobile     :string(255)      not null
#  code       :string(255)      default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sms do
  end
end
