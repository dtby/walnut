module ApplicationHelper
	def format_time time
		return "" if time.blank?
		time.strftime("%Y年%m月%d日 %H:%M")
	end
end
