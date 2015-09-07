class Apply < ActiveRecord::Base
	validates :openid, :name, :sex, :phone, :qq, :situation, :degree, :way, :train_name, :school_name, presence: true
	validates :name, format: { with: /[\u4e00-\u9fa5]/ , message: "请输入正确的姓名"}
	validates :phone, format: { with: /\A(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}\z/, message: "请输入正确的手机号码" }
	validates :qq, format: { with: /[1-9][0-9]{4,}/, message: "请输入正确的QQ号码" }

	#性别
	enum sex: { man: true, woman: false }
	SEX = { man: '男', woman: '女' }
	#现状
	enum situation: {
		work: '0',
		diswork: '1',
		student: '2'
	}
	SITUATION = { work: '在职', diswork: '待业', student: '学生' }
	#教育状况
	enum degree: {
		master: '3',
		university: '4',
		vocation: '5',
		other: '6'
	}
	DEGREE = { master: '研究生', university: '本科', vocation: '高职', other: '其他' }
	#了解渠道
	enum way: {
		teacher: '7',
		school: '8',
		friend: '9',
		buoyantec: '10',
		another: '11'
	}
	WAY = { teacher: '老师推荐', school: '校园宣讲', friend: '朋友介绍', buoyantec: '邦彦网站', another: '其他' }
	#培训课程
	enum train_name: {
		ios: '12',
		android: '13',
		web: '14'
	}
	TRAIN_NAME = { ios: 'ios开发', android: '安卓开发', web: 'WEB全栈' }
	#查询各班报名情况
	def self.students train_name
		if train_name.nil?
			return self.all
		else
			where( train_name: train_name )
		end
	end
end
