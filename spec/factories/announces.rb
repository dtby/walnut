# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :announce do
    title "MyString"
    description "MyText"
    project nil
  end
end
