# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "核桃网项目管理"
    description "核桃网项目管理描述"
    is_public false
  end
end
