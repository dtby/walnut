class Apply < ActiveRecord::Base
	#validates :openid, :sex, :phone, :qq, :email, :address, :situation, :degree, :way, :train_name, presence: true
	#validates :phone, :qq , numericality:  { only_integer: true }

	#性别
	enum sex: { open: true, close: false }
	SEX = { open: '男', close: '女' }
	#现状
	enum situation: {
		'在职' => 'on_work',
		'待业' => 'wait_work',
		'学生' => 'student'
	}
	#教育状况
	enum degree: {
		'研究生' => 'graduate',
		'本科' => 'undergraduate',
		'高职' => 'vocational',
		'其他' => 'other'
	}
	#了解渠道
	enum way: {
		'老师推荐' => 'teacher',
		'校园宣讲' => 'school',
		'朋友介绍' => 'friend',
		'邦彦网站' => 'buoyantec',
		'其它' => 'another'
	}
	#培训课程
	enum train_name: {
		'ios开发' => 'ios',
		'安卓开发' => 'android',
		'web全栈' => 'web'
	}
end
