module SubCoursesHelper
	#计算发布评论距今的时间
	def time_interval comment
		cmt = comment.created_at
		current = Time.current
		if current.year > cmt.year 
			return "#{current.year > cmt.year} 年前"
		elsif current.month > cmt.month
			return "#{current.month - cmt.month} 月前"
		elsif current.day > cmt.day
			return "#{current.day - cmt.day} 天前"
		elsif current.hour > cmt.hour
			return "#{current.hour - cmt.hour} 小时前"
		elsif cmt.min > current.min
			return "#{current.min - cmt.min} 分钟前"
		else 
			return "刚刚"
		end
	end
end
