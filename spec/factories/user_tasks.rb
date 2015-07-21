# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_task do
    user nil
    task nil
    role 1
  end
end
