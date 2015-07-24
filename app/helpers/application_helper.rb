module ApplicationHelper
	def format_time time
		return "" if time.blank?
		time.strftime("%Y年%m月%d日 %H:%M")
	end

   def is_edit_or_update?
    params[:action] == "edit" || params[:action] == "update"
  end

  #根据index显示项目的背景色
  def project_bc index
    case index%4
    when 0
      "blue-bg"
    when 1
      "yellow-bg"
    when 2
      "orange-bg"
    when 3
      "purple-bg"
    end
  end
end
