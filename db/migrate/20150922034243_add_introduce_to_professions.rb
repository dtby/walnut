class AddIntroduceToProfessions < ActiveRecord::Migration
  def change
    add_column :professions, :introduce, :text
  end
end
