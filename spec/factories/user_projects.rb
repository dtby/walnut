# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_project do
    user nil
    project nil
    role 1
  end
end
