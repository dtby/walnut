# == Schema Information
#
# Table name: recruitments
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  gender           :string(255)
#  certificate      :string(255)
#  degree_id        :integer
#  company_id       :integer
#  category         :string(255)
#  city             :string(255)
#  remuneration     :string(255)
#  foreign_language :string(255)
#  others           :string(255)
#  description      :text(65535)
#  hr_email         :string(255)
#  browse_count     :integer          default(0)
#  publish_time     :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  industry         :string(255)
#  number           :integer
#  view_count       :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recruitment do
    name "MyString"
    gender "MyString"
    certificate "MyString"
    references ""
    references ""
    category "MyString"
    city "MyString"
    remuneration "MyString"
    foreign_language "MyString"
    others "MyString"
    description "MyText"
    hr_email "MyString"
    browse_count "MyString"
    publish_time "MyString"
  end
end
