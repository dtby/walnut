class AddTrainNameToStudents < ActiveRecord::Migration
	def change
		add_column :students, :train_name, :string
	end
end
