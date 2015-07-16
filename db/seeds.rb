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
 logo_url:"0401_1.png",
  name:"大唐邦彦",
  description:"大唐邦彦（上海）信息技术有限公司（简称大唐邦彦）是一家专注于移动互联网信息技术、大数据云平台、教育行业信息化、校企合作产教融合开发的高科技企业。集合大唐电信科技产业集团优势资源，依托集团研发实力和企业大学的教学经验，大唐邦彦与国内外多所知名教育研究机构、高校建立了战略伙伴关系，将校企合作由原来的共建产教融合基地、人才创新基地等扩展到专业领域的人才培养，进行专业学科建设的设计与实施、在线教育平台的综合应用，并自主开发集成了FITWARE系列实训室整体解决方案，从专业共建、技能培训、实习实训、就业指导、创业孵化等全流程的培养方案，实现产业需求与高校教育内容、教学过程的深度融结合",
  address:"上海市香港路53号",
  web_address:"www.dtbytec.com",
  contact:"叶小姐",
  contact_phone:"13162787916",}])

Recruitment.destroy_all
 (1..36).each do |i| 
  Recruitment.create!([
  { id:i,
    name: "前端研发工程师", 
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
  image_url:""
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

College.destroy_all
College.create!([
  { name: "北京大学" },
  { name: "上海复旦大学" },
  {name: "上海j交通大学"},
  {name: "清华大学"},
  {name: "中原工学院"},
  {name: "中国人民大学"},
  {name: "浙江大学"}
])

Category.destroy_all
Category.create!([
  {name: "计算机"},
  {name: "艺术设计"},
  {name: "信息传播"},
  {name: "电子电气工程"},
  {name: "数据分析"},
  {name: "水利工程"},
  {name: "土木工程"},
  {name: "社会科学"},
  {name: "测控技术与仪器"},
  {name: "材料科学"},
  {name: "机械工程"},
  {name: "教育"},
  {name: "光信息科学与技术"}
  ])

Teacher.destroy_all
Teacher.create!([
  {name: "赵国栋", description: "北京大学教育学院教授"},
  {name: " 俞敬松", description: "北京大学副教授"},
  {name: " 沈晴霓", description: "博士，副教授，北京大学...."}
])
