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
        Spider.parse_single_company practise_url+link['href']
      end
    end

  end

  

  
end



