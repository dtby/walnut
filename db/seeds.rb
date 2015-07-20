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
    description: "<h4>【岗位职能】</h4>
      <p>1.负责WEB方面培训的日常授课以及课程研发和升级，教材的编写；</p>
      <p>2.讨论教学相关项目的需求，参与案例设计，完成设计文档以及核心模块编写；</p>
      <p>3.解决案例开发过程中的实际项目和业务问题；</p>
      <p>4.参与新技术预研并做技术分享。</p><h4>【任职要求】</h4>
      <p>1. 计算机相关专业，本科及以上学历；</p>
      <p>2. 2年以上Web实际开发经验，能够独立承担设计、编码、测试工作；</p>
      <p>3. 熟悉HTML5、CSS3，熟悉W3C标准，对页面性能和浏览器兼容有丰富的实践经验；</p>
      <p>4. 熟悉Web2.0标准，精通JavaScript、Ajax、DOM、XML、JSON等前端开发技术，能够持续的优化前端体验和页面响应速度，并保证兼容性和执行效率；</p>
      <p>5. 精通Jquery，熟悉各种常见 JS 开发框架，如AngularJS、Bootstrap、NodeJS等；</p>
      <p>6. 了解移动开发，对于响应式布局有一些实践经验；</p>
      <p>7. 熟悉至少一种后端开发语言更佳，比如Java，Php，rails等；</p>
      <p>8.能主动与学生沟通，关心学生，并督促学生认真学习；</p>
      <p>9.普通话标准，语言表达能力强，逻辑思维清晰，具有优秀的沟通技巧；</p>
      <p>10.热爱教育事业，有良好的敬业心；有相关授课经验者优先。</p><h4>【福利待遇】</h4><p>福利待遇：五险一金，带薪年假，团队旅游，节日福利。</p>
      <h4>【薪资范围】</h4><p>薪资范围：6K-10K</p>
      <h4>【职位诱惑】</h4><p>职位诱惑：处于快速发展期的公司，提供广阔的发展平台；后期可入职到学校，工作稳定，可同时享受学校的相关福利待遇。</p>
      <h4>【联系方式】</h4><p>联系人：叶小姐     电话：13162787916</p>",
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
(1..158).each do |i|
  Interview.create!([
  {title: "各行业应聘英语要求(2013校园招聘)", 
  content: "TOEIC听读630分以上/ 四级425分以上托福70分以上/ 雅思5.5分以上中国工商银行TOEIC听读715分及以上/ 六级425分及以上托福85分及以上/ 雅思6.5分及以上交通银行TOEIC听读750分及以上/ 六级中国建设银行托业715分及以上/ 六级425分以上托福85分以上/ ",
  iv_category_id: 1,
  view_count: 255,
  public_time: "2015-07-16",
  image_url: ""
  },
  {title: "各行业应聘英语要求(2013校园招聘)", 
  content: "TOEIC听读630分以上/ 四级425分以上托福70分以上/ 雅思5.5分以上中国工商银行TOEIC听读715分及以上/ 六级425分及以上托福85分及以上/ 雅思6.5分及以上交通银行TOEIC听读750分及以上/ 六级中国建设银行托业715分及以上/ 六级425分以上托福85分以上/ ",
  iv_category_id: 2,
  view_count: 255,
  public_time: "2015-07-16",
  image_url: "interviews_pic.png"
  },
  {title: "各行业应聘英语要求(2013校园招聘)", 
  content: "TOEIC听读630分以上/ 四级425分以上托福70分以上/ 雅思5.5分以上中国工商银行TOEIC听读715分及以上/ 六级425分及以上托福85分及以上/ 雅思6.5分及以上交通银行TOEIC听读750分及以上/ 六级中国建设银行托业715分及以上/ 六级425分以上托福85分以上/ ",
  iv_category_id: 1,
  view_count: 255,
  public_time: "2015-07-16",
  image_url: "interviews_pic.png"
  }
  ])
end


College.destroy_all
College.create!([
  { name: "北京大学" },
  { name: "上海复旦大学" },
  {name: "上海交通大学"},
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
