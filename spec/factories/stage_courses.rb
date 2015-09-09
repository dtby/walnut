# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stage_course do
    course nil
    stage_courseable nil
    polymorphic ""
  end
end
