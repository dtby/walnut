class Apply < ActiveRecord::Base
	validates :openid, :name, :sex, :phone, :qq, :email, :address, :situation, :degree, :way, :train_name, presence: true
	validates :name, format: { with: /[\u4e00-\u9fa5]/ , message: "请输入正确的姓名"}
	validates :phone, format: { with: /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/, message: "请输入正确的手机号码" }
	validates :qq, format: { with: /[1-9][0-9]{4,}/, message: "请输入正确的QQ号码" }
	validates :email, format: { with: /\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, message: "请输入正确的的email" }

	#性别
	enum sex: { man: true, woman: false }
	SEX = { man: '男', woman: '女' }
	#现状
	enum situation: {
		work: 's1',
		diswork: 's2',
		student: 's3'
	}
	SITUATION = { work: '在职', diswork: '待业', student: '学生' }
	#教育状况
	enum degree: {
		master: 'd1',
		university: 'd2',
		vocation: 'd3',
		other: 'd4'
	}
	DEGREE = { master: '研究生', university: '本科', vocation: '高职', other: '其他' }
	#了解渠道
	enum way: {
		'老师推荐' => 'teacher',
		'校园宣讲' => 'school',
		'朋友介绍' => 'friend',
		'邦彦网站' => 'buoyantec',
		'其他' => 'another'
	}
	#培训课程
	enum train_name: {
		'ios开发' => 'ios',
		'安卓开发' => 'android',
		'WEB全栈' => 'web'
	}
	#验证报名课程是否已存在
	def self.valid_create(params)
		apply = self.find_by_train_name(params[:train_name])
		if apply.present?
			return 'present'
		elsif val == 0
			self.new(params)
		end
	end

	#验证更新报名课程是否已存在
	def self.valid_update(params)
		
	end

	#查询各班报名情况
	def self.students train_name
		if train_name.nil?
			return self.all
		else
			where( train_name: train_name )
		end
	end
end
