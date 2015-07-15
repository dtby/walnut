# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Degree.destroy_all
Degree.create!([{id: 1, name: "高中/中专", sort_no: 1},
  {id: 2, name: "大专", sort_no: 2},
  {id: 3, name: "本科", sort_no: 3},
  {id: 4, name: "硕士", sort_no: 4},
  {id: 5, name: "博士", sort_no: 5},
  {id: 6, name: "其他", sort_no: 6}])

Company.destroy_all
Company.create!([{id:1,
 logo_url:"www.dtbytec.com",
  name:"大唐邦彦",
  description:"校企合作深度院系校企合作深度院系校企合作深度院系校企合作深度院系校企合作深度院系校企合作深度院系",
  address:"上海市香港路53号",
  web_address:"www.dtbytec.com",
  contact:"叶小姐",
  contact_phone:"13162787916",
  sort_no:1}])

Recruitment.destroy_all
Recruitment.create!([
  {id:1, 
    name:"John", 
    gender:"男", 
    certificate:"英语六级", 
    degree_id:3, 
    company_id:1, 
    city:"上海", 
    remuneration:"面议",
    foreign_language:"英语",
    others:"无",
    description:"前端工程师",
    hr_email:"example@dtbytec.com",
    publish_time:"2015-07-08",
    category:"软件工程师",
    industry:"互联网"}])

Iv_category.destroy_all
Iv_category.create!([{id: 1, name: "通用材料", sort_no: 1},
  {id: 2, name: "HR/雇主视角", sort_no: 2},
  {id: 3, name: "面试类型", sort_no: 3},
  {id: 4, name: "面试准备", sort_no: 4},
  {id: 5, name: "面试过程", sort_no: 5},
  {id: 6, name: "面试之后", sort_no: 6},
  {id: 7, name: "经验/经历/心得", sort_no: 7}])
