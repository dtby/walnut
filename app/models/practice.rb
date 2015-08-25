class Practice < ActiveRecord::Base
	has_and_belongs_to_many :students

	validates :name, presence: true

	enum name: {
		'ios开发' => 'ios',
		'安卓开发' => 'android',
		'web全栈' => 'web'
	}
end
