# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  view_count  :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  teacher_id  :integer
#  college_id  :integer
#  category_id :integer
#  detail      :text(65535)
#

class Course < ActiveRecord::Base
	has_one :image, as: :imageable, dependent: :destroy
	has_one :attachment, as: :attachmentable, dependent: :destroy
	has_many :sub_courses, dependent: :destroy
	#has_many_kindeditor_assets :attachments, :dependent => :destroy
	belongs_to :teacher
	belongs_to :category
	belongs_to :college
	has_many :project_courses

  #子课程最后更新时间
	def last_update_time
		self.sub_courses.present? ? self.sub_courses.last.updated_at : self.updated_at
	end

	#课程包含全部子课程时间
	def total_length
		time = 0
		if self.sub_courses.present?
		   self.sub_courses.each do |sub_course|
		       time = FFMPEG::Movie.new("public"+sub_course.attachment.content.url.to_s).duration 
	          end
		end
		if time > 0
			alltime = time.ceil
			hour =  (alltime / 3600)
			min = (alltime - hour * 3600) / 60
			sec = (alltime - hour * 3600 - min * 60)
			return "#{hour}小时 #{min}分钟 #{sec}秒"
		else
			return "-- -- --"
		end
	end

	#搜索
	searchable do
    text :title
    integer :teacher_id
    integer :college_id
  end

end
