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
