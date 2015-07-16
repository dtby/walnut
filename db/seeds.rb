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
  contact_phone:"13162787916",}])

Recruitment.destroy_all
 (1..36).each do |i| 
  Recruitment.create!([
  { id:i,
    name: "John", 
    gender: "男", 
    certificate: "英语六级", 
    degree_id: 3, 
    number: "4",
    company_id: 1, 
    city: "上海", 
    remuneration: "面议",
    foreign_language: "英语",
    others: "无",
    description: "前端工程师",
    hr_email: "example@dtbytec.com",
    publish_time: "2015-07-08",
    category: "软件工程师",
    industry: "互联网"}])
  end

IvCategory.destroy_all
IvCategory.create!([{id: 1, name: "通用材料", sort_no: 1},
  {id: 2, name: "HR/雇主视角", sort_no: 2},
  {id: 3, name: "面试类型", sort_no: 3},
  {id: 4, name: "面试准备", sort_no: 4},
  {id: 5, name: "面试过程", sort_no: 5},
  {id: 6, name: "面试之后", sort_no: 6},
  {id: 7, name: "经验/经历/心得", sort_no: 7}])


Interview.destroy_all
Interview.create!([
  {id:1, title:"各行业应聘英语要求(2013校园招聘)", 
  content:"TOEIC听读630分以上/ 四级425分以上托福70分以上/ 雅思5.5分以上中国工商银行TOEIC听读715分及以上/ 六级425分及以上托福85分及以上/ 雅思6.5分及以上交通银行TOEIC听读750分及以上/ 六级中国建设银行托业715分及以上/ 六级425分以上托福85分以上/ ",
  iv_category_id:1,
  view_count:255,
  public_time:"2015-07-16",
  image_url:"www.dtbytec.com"
  },
  {id:2, title:"各行业应聘英语要求(2013校园招聘)", 
  content:"TOEIC听读630分以上/ 四级425分以上托福70分以上/ 雅思5.5分以上中国工商银行TOEIC听读715分及以上/ 六级425分及以上托福85分及以上/ 雅思6.5分及以上交通银行TOEIC听读750分及以上/ 六级中国建设银行托业715分及以上/ 六级425分以上托福85分以上/ ",
  iv_category_id:2,
  view_count:255,
  public_time:"2015-07-16",
  image_url:"www.dtbytec.com"
  },
  {id:3, title:"各行业应聘英语要求(2013校园招聘)", 
  content:"TOEIC听读630分以上/ 四级425分以上托福70分以上/ 雅思5.5分以上中国工商银行TOEIC听读715分及以上/ 六级425分及以上托福85分及以上/ 雅思6.5分及以上交通银行TOEIC听读750分及以上/ 六级中国建设银行托业715分及以上/ 六级425分以上托福85分以上/ ",
  iv_category_id:1,
  view_count:255,
  public_time:"2015-07-16",
  image_url:"www.dtbytec.com"
  }
  ])
