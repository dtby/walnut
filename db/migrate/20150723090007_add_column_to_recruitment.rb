class AddColumnToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :nature, :string
    add_column :recruitments, :department, :string
    add_column :recruitments, :need_person, :string
    add_column :recruitments, :stop_time, :datetime
    add_column :recruitments, :must_school, :string
    add_column :recruitments, :must_specialty1, :string
    add_column :recruitments, :must_specialty2, :string
    add_column :recruitments, :age, :string
    add_column :recruitments, :experience, :string
    add_column :recruitments, :it_tec, :string
    add_column :recruitments, :responsibility, :text
    add_column :recruitments, :demand, :text
    add_column :recruitments, :recruit_type, :integer, default: 0
    change_column :recruitments, :publish_time, :datetime
    remove_column :recruitments, :view_count
  end
end
