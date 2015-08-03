require "pp"

class Spider

  def self.parse_single_company url
    create_params = {}
    info_hash = {}
    page = @agent.get url
    doc = Nokogiri::HTML(page.content)
    panel_body = doc.css('div[class="panel-body panel-body-text"]')
    panel_body.each do |content|
      create_params[:description] = content.content
    end

    col = doc.css('div[class="col-xs-6"]')
    col.each do |info|
      ps = col.css('p[class="text-ellipsis"]')

      ps.each do |p|
        value = p.css('span[class="margin left"]')
        value.each do |span|
          info_hash[p.content[0..3]] = span.content
        end
      end
    end

    create_params[:city] = ""
    create_params[:publish_time] = ""
    info_hash.each do |key, value|
      case key
      when "信息来源"

      when "涉及城市"
        create_params[:city] = value
      when "信息标签"

      when "发布时间"
        create_params[:publish_time] = value
      when "发布来源"
      when "点击次数"
      end
    end
    recruitment = Recruitment.create create_params
    
  end

  def self.get_practise_info
    index_url = "http://home.haitou.cc/"
    practise_url = "http://sxxx.haitou.cc"

    @agent = Mechanize.new
    page = @agent.get practise_url

    doc = Nokogiri::HTML(page.content)

    doc.css('a').each do |link|
      unless link.css('company').empty? || link.content.include?("官方")
        #Spider.parse_single_company practise_url+link['href']
      end
    end

  end


  #抓取海投网招聘信息
  def self.get_recruitments page_count = 1700
    index_url = "http://xyzp.haitou.cc"
    #分页用url
    paginate_url = "/sh/uni-0/all/"

    #分页用url
    paginate_url = "/sh/uni-0/all/"

    #获取所有官方公司在海投网的link
    com_infos = get_company_links index_url, paginate_url, page_count
    company_links = com_infos[0]
    index_other_infos = com_infos[1]

    #根据官方link爬取数据并保存对应数据信息
    save_infos_by_company_link index_url, company_links, index_other_infos, 1
  end

  #抓取海投网实习信息
  #page_count :抓取总页数
  def self.get_practices page_count = 300
    index_url = "http://sxxx.haitou.cc"

    #分页用url
    paginate_url = "/sh/uni-0/all/"

    #获取所有官方公司在海投网的link
    com_infos = get_company_links index_url, paginate_url, page_count
    company_links = com_infos[0]
    index_other_infos = com_infos[1]

    #根据官方link爬取数据并保存对应数据信息
    save_infos_by_company_link index_url, company_links, index_other_infos, 2
    
  end

  #参数：index_url，待爬取网站信息url
  #paginate_url，分页用url
  #page_count：总页数
  def self.get_company_links index_url, paginate_url, page_count
    company_links = []
    index_other_infos = []

    agent = Mechanize.new
    (1..page_count).each do |i|

      #根据分页取得每页的路径
      i == 1 ? (url = index_url) : (url = index_url + paginate_url + i.to_s + "/")

      begin
        #获取doc结构
        page = agent.get url
        doc = Nokogiri::HTML(page.content)

        #去官方实习、招聘信息公司的link
        doc.css('tbody[class="preach-tbody"] tr').each do |tr|
          link = tr.css('td[class="preach-tbody-title"] a')[0]
          if link.content.include?("官方")
            #已经存在的link不选择
            unless company_links.include? link['href']
              company_links.push(link['href']) 
              others = {}
              others[:publish_time] = tr.css('td span[class="hold-ymd"]')[0].try(:content)
              others[:browse_count] = tr.css('td:last-child')[0].try(:content)
              #记录其他信息
              index_other_infos.push others
            end
            
          end
        end

      rescue Exception => e
        next
      end
    end

    [company_links,index_other_infos]
  end

  #根据官方link爬取数据并保存对应数据信息
  #参数：company对应link集合
  #index_url，待爬取网站信息url
  #index_other_infos 发布时间
  #recruit_type, 1是招聘信息，2是实习信息
  def self.save_infos_by_company_link index_url, company_links, index_other_infos, recruit_type
    agent = Mechanize.new

    #循环公司，抓取职位信息
    company_links.each_with_index do |link, index|
      url = index_url + link

      begin
        page = agent.get url

        doc = Nokogiri::HTML(page.content)

        #保存公司信息根据公司主页link
        company = save_company "http://gs.haitou.cc" + doc.xpath('//*[@id="kz-web"]/div[3]/div/div[1]/ul/li[1]/a')[0]["href"]
        if company.present?
          #当前公司所有职位处理
          doc.css('div[class="ssjg_name text-success text_ellipsis"] a').each do |link|
            #依次save当前公司则职位
            save_recruitment_by_link("http:" + link["href"],company, index_other_infos[index],recruit_type)
          end
        end
      rescue Exception => e
        next
      end

    end
  end

  #保存公司信息
  #参数：公司在海投的主页link
  def self.save_company link
    agent = Mechanize.new
    #logo url前缀
    company_pre_url = "http://gs.haitou.cc/"
    company = nil 
    begin
      page = agent.get link
      doc = Nokogiri::HTML(page.content)
      
      #公司名称
      name = doc.xpath('//*[@id="kz-web"]/div[2]/div/div/h3')[0].try(:content).try(:strip)

      company = Company.find_or_create_by(name: name)

      #公司logo
      logo_url = doc.css('.ssjg_logo img')[0].present? ? doc.css(".ssjg_logo img")[0]["src"] : ""

      logo_url = company_pre_url + logo_url unless logo_url.include?("http://")
      logo_url = "" if logo_url.include? "default_logo.gif"

      company.logo_url = logo_url 

      #公司介绍
      description = doc.xpath('//*[@id="kz-web"]/div[3]/div[1]/div[2]/div[2]')[0].try(:to_html).split('<hr>', 2)[1]
      company.description = (description[0,description.index("</div>",6)] rescue "")

      #其他字段处理
      other_fileds = ["city" ,"industry", "scale", "web_address"]
      doc.css('div[class="panel-body"] div[class="row"] p[class="col-xs-6"]').each_with_index do |con, index|
        if index == 3
          company[other_fileds[index]] = con.css('a')[0]["href"] unless con.css('a')[0].blank?
        elsif index == 1
          company["industry"] = con.try(:content).try(:split,":")[1].try(:split, "(")[0].try(:strip)
          company["nature"] = con.try(:content).try(:split,":")[1].try(:split, "(")[1].try(:gsub, /公司\)/, "").try(:strip)
        else
          company[other_fileds[index]] = con.try(:content).try(:split,":")[1].try(:strip)
        end
      end

      company.save(validate: false)
    rescue Exception => e
      pp "======================save_company error====================="
      pp e
      pp "======================save_company error====================="
    end
    company
  end


  #保存招聘信息
  #参数：link，职位介绍页链接
  #招聘信息所属
  #index_other_info 其他信息
  #recruit_type, 1是招聘信息，2是实习信息
  def self.save_recruitment_by_link link, company, index_other_info, recruit_type
    agent = Mechanize.new
    recruitment = nil
    begin
      page = agent.get link
      doc = Nokogiri::HTML(page.content)

      name = doc.xpath('//*[@id="kz-web"]/div[3]/div/div[1]/div/h2')[0].try(:content)
      recruitment = Recruitment.find_or_create_by(name: name, company_id: company.try(:id))

      recruitment.recruit_type = recruit_type
      recruitment.recruit_type = 2 if name.include?("实习")

      #招聘信息发布时间
      recruitment.publish_time = index_other_info[:publish_time]
      recruitment.browse_count = index_other_info[:browse_count]
      recruitment.hr_email = "dev@buoyantec.com"

      #工作地点等字段保存
      doc.css('div[class="panel-body"] div[class="row"] p[class="col-xs-6"]').each do |con|
        type = con.content.split("：")
        case type[0].try(:strip)
        when "工作地点"
          recruitment.city = type[1].try(:strip)
        when "工作性质"
          recruitment.nature = type[1].try(:strip)
        when "职位类型"
          recruitment.category = type[1].try(:strip) || ""
          recruitment.recruit_type = 2 if recruitment.nature.include?("实习")
        when "薪资水平"
          recruitment.remuneration = type[1].try(:strip)
        when "所属部门"
          recruitment.department = type[1].try(:strip)
        when "招聘人数"
          recruitment.need_person = type[1].try(:strip)
        when "发布时间"
          recruitment.publish_time = type[1].try(:strip).try(:to_time)  if type[1].try(:strip).present?
        when "截止时间"
          recruitment.stop_time = type[1].try(:strip).try(:to_time) 
        when "点击量"
          recruitment.browse_count = type[1].try(:strip)
        end
      end

      #some_fileds = ["city", "nature", "remuneration", "department", "need_person", "stop_time"]
      # doc.css('div[class="panel-body"]').each_with_index do |con, index|
      #   infos = con.try(:content).try(:split,"：")
      #   next unless infos.length == 2
      #   if infos[0] == "职位性质"
      #     two_values = infos[1].split("[")
      #     next unless two_values.length == 2
      #     recruitment[some_fileds[index]] = two_values[0].try(:strip)
      #     recruitment.category = two_values[1].try(:gsub,"]","").try(:strip)
      #   elsif infos[0] == "截止时间"
      #     recruitment[some_fileds[index]] = infos[1].try(:strip).try(:to_time) 
      #   else
      #     recruitment[some_fileds[index]] = infos[1].try(:strip) 
      #   end
      # end

      #工作职责、职位要求保存
      # doc.css('div[class="con_in"] div + p').each_with_index do |con, index|
      #   if index == 0
      #     recruitment.responsibility = con.try(:content).try(:gsub,/\r\n/,'<br>').try(:gsub,/[;；]/,'；<br>').try(:gsub,/。/,'。<br>').try(:gsub,/：/,':<br>')
      #   elsif index == 1
      #     recruitment.demand = con.try(:content).try(:gsub,/\r\n/,'<br>').try(:gsub,/[;；]/,'；<br>').try(:gsub,/。/,'。<br>').try(:gsub,/：/,':<br>')
      #   end
      # end
      recruitment.responsibility = doc.css('#kz-web > div:nth-child(3) > div > div:nth-child(1) > div > p:nth-child(12)')[0].try(:to_html)
      recruitment.demand = doc.css('#kz-web > div:nth-child(3) > div > div:nth-child(1) > div > p:nth-child(15)')[0].try(:to_html)
      recruitment.others = doc.css('#kz-web > div:nth-child(3) > div > div:nth-child(1) > div > p:nth-child(18)')[0].try(:to_html)

      #其他字段保存
      # other_fileds = ["must_school", "must_specialty1", "degree_id", "must_specialty2", 
      #   "age", "experience", "foreign_language", "it_tec", "certificate"]
      # doc.css('ul[class="con_cell con_pos_cell"] li').each_with_index do |con, index|
      #   infos = con.try(:content).try(:split,"：")
      #   next unless infos.length == 2
      #   if infos[0] == "学历"
      #     recruitment[other_fileds[index]] = Degree.find_or_create_by(name: infos[1].try(:strip)).try(:id)
      #   else
      #     recruitment[other_fileds[index]] = infos[1].try(:strip) 
      #   end
      # end

      recruitment.save(validate: false)
    rescue Exception => e
      pp "======================save_recruitment_by_link error====================="
      pp e.message
      pp "======================save_recruitment_by_link error====================="
    end

    recruitment
  end



  #测试用
  def self.test
    agent = Mechanize.new
    page = agent.get "http://zw.haitou.cc/4364"

    doc = Nokogiri::HTML(page.content)

#kz-web > div:nth-child(3) > div > div:nth-child(1) > div > p:nth-child(15)
#kz-web > div:nth-child(3) > div > div:nth-child(1) > div > p:nth-child(15)
#kz-web > div:nth-child(3) > div > div:nth-child(1) > div > p:nth-child(18)
    doc.css('div[class="panel-body"] div[class="row"] p[class="col-xs-6"]').each do |con|
      type = con.content.split("：")
      pp type
      case type[0].try(:strip)
      when "工作地点"
        pp type[1].try(:strip)
      when "工作性质"
        pp type[1].try(:strip)
      when "职位类型"
        pp type[1].try(:strip) 
      when "薪资水平"
        pp type[1].try(:strip)
      when "所属部门"
        pp type[1].try(:strip)
      when "招聘人数"
        pp type[1].try(:strip)
      when "发布时间"
        pp type[1].try(:strip).try(:to_time) 
      when "截止时间"
        pp type[1].try(:strip).try(:to_time) 
      when "点击量"
        pp type[1].try(:strip)
      end
    end
  end



end



