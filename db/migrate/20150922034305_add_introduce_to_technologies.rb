class AddIntroduceToTechnologies < ActiveRecord::Migration
  def change
    add_column :technologies, :introduce, :text
  end
end
