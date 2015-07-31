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
pp company_links
    #根据官方link爬取数据并保存对应数据信息
    #save_infos_by_company_link index_url, company_links, index_other_infos, 2
    
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
        # if company.present?
        #   #当前公司所有职位处理
        #   doc.css('ul[class="con_pos company_position"] a').each do |practice_link|
        #     #依次save当前公司则职位
        #     save_recruitment_by_link("http://company.haitou.cc" + practice_link["href"],company, index_other_infos[index],recruit_type)
        #   end
        # end
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
      logo_url = doc.css('.ssjg_logo img')[0].present? ? doc.xpath(".ssjg_logo img")[0]["src"] : ""

      logo_url = "" if logo_url.include? "etp.gif"
      company.logo_url = company_pre_url + logo_url unless logo_url.blank?
      #公司介绍
      description = doc.css('div[class="company_info"]')[0].try(:to_html)
      company.description = description.split(":",2)[0] + ":100%" + description.split(":",2)[1].split("px",2)[1] unless description.blank?

      #其他字段处理
      other_fileds = ["industry", "nature", "city", "scale", "address", "web_address"]
      doc.css('ul[class="con_cell"] li font').each_with_index do |font,index|
        unless font.try(:content).try(:strip) == "点击查看公司主页"
          company[other_fileds[index]] = font.try(:content).try(:strip)
        else
          company[other_fileds[index]] = font.css('a')[0]["href"] unless font.css('a')[0].blank?
        end
      end

      company.save(validate: false)
    rescue Exception => e
      pp "======================save_company error====================="
      pp e.message
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

      name = doc.css('div[class="con_name"]')[0].try(:content)
      recruitment = Recruitment.find_or_create_by(name: name, company_id: company.try(:id))

      recruitment.recruit_type = recruit_type
      recruitment.recruit_type = 2 if name.include?("实习")

      #招聘信息发布时间
      recruitment.publish_time = index_other_info[:publish_time]
      recruitment.browse_count = index_other_info[:browse_count]
      recruitment.hr_email = "dev@buoyantec.com"

      #工作地点等字段保存
      some_fileds = ["city", "nature", "remuneration", "department", "need_person", "stop_time"]
      doc.css('div[class="con_in"] p[class="part"]').each_with_index do |con, index|
        infos = con.try(:content).try(:split,"：")
        next unless infos.length == 2
        if infos[0] == "职位性质"
          two_values = infos[1].split("[")
          next unless two_values.length == 2
          recruitment[some_fileds[index]] = two_values[0].try(:strip)
          recruitment.category = two_values[1].try(:gsub,"]","").try(:strip)
        elsif infos[0] == "截止时间"
          recruitment[some_fileds[index]] = infos[1].try(:strip).try(:to_time) 
        else
          recruitment[some_fileds[index]] = infos[1].try(:strip) 
        end
      end

      #工作职责、职位要求保存
      doc.css('div[class="con_in"] div + p').each_with_index do |con, index|
        if index == 0
          recruitment.responsibility = con.try(:content).try(:gsub,/\r\n/,'<br>').try(:gsub,/[;；]/,'；<br>').try(:gsub,/。/,'。<br>').try(:gsub,/：/,':<br>')
        elsif index == 1
          recruitment.demand = con.try(:content).try(:gsub,/\r\n/,'<br>').try(:gsub,/[;；]/,'；<br>').try(:gsub,/。/,'。<br>').try(:gsub,/：/,':<br>')
        end
      end

      #其他字段保存
      other_fileds = ["must_school", "must_specialty1", "degree_id", "must_specialty2", 
        "age", "experience", "foreign_language", "it_tec", "certificate"]
      doc.css('ul[class="con_cell con_pos_cell"] li').each_with_index do |con, index|
        infos = con.try(:content).try(:split,"：")
        next unless infos.length == 2
        if infos[0] == "学历"
          recruitment[other_fileds[index]] = Degree.find_or_create_by(name: infos[1].try(:strip)).try(:id)
        else
          recruitment[other_fileds[index]] = infos[1].try(:strip) 
        end
      end

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
    page = agent.get "http://gs.haitou.cc/2410"

    doc = Nokogiri::HTML(page.content)

     #公司名称
    name = doc.xpath('//*[@id="kz-web"]/div[2]/div/div/h3')[0].try(:content).try(:strip)

    #公司logo
    logo_url = doc.css('.ssjg_logo img')[0]["src"]
    pp name,logo_url

    pp doc.xpath('//*[@id="kz-web"]/div[3]/div[1]/div[2]/div[2]')[0].try(:to_html).split('<hr>', 2)[1]

    # doc.css('tbody[class="preach-tbody"] tr').each do |tr|
    #   link = tr.css('td[class="preach-tbody-title"] a')[0]
    #   if link.content.include?("官方")
    #     #已经存在的link不选择
    #        pp link['href']
    #        pp tr.css('td span[class="hold-ymd"]')[0].try(:content)
    #        pp tr.css('td:last-child')[0].try(:content)
        
    #   end
    # end
  end



end



