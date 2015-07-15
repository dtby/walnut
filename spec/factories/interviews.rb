# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interview do
    title "MyString"
    content "MyString"
    iv_category nil
    browse_count 1
  end
end
