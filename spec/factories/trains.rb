# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :train do
    title "MyString"
    pv 1
    introduce "MyText"
    syllabus "MyText"
    prospect "MyText"
    characteristic "MyText"
    picture_url "MyString"
    content "MyText"
    picture_url "MyString"
  end
end
