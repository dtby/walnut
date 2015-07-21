# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_notification do
    user nil
    notification nil
    state 1
  end
end
