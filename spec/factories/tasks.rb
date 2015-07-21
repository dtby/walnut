# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    project nil
    task_category nil
    No 1
    name "MyString"
    description "MyString"
    end_time "2015-07-21"
    level 1
    state 1
  end
end
