# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task_category do
    project nil
    name "MyString"
    description "MyString"
  end
end
