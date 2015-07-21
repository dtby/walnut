# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :task do
    project nil
    task_category nil
    #No 1
    name "个人中心静态页面"
    description "完成个人中心的所有静态页面"
    end_time "2015-07-21"
    level 1
    #state 1
  end
end
