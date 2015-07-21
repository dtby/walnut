# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :task_category do
    project Project.first || FactoryGirl.create(:project)
    name "个人中心"
    description "个人中心所有功能"
  end
end
