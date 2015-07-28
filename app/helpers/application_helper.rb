module ApplicationHelper
	def format_time time
		return "" if time.blank?
		time.strftime("%Y年%m月%d日 %H:%M")
	end

   def is_edit_or_update?
    params[:action] == "edit" || params[:action] == "update"
  end

  
  #前台title显示
  def title
    "核桃在线"
  end

end
