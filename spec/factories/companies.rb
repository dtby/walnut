# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name "MyString"
    description "MyText"
    address "MyString"
    web_address "MyString"
    contact_phone "MyString"
    contact "MyString"
  end
end
