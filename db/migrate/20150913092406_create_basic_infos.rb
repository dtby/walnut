class CreateBasicInfos < ActiveRecord::Migration
  def change
    create_table :basic_infos do |t|
      t.string :education
      t.string :intention
      t.string :skill
      t.string :city

      t.timestamps null: false
    end
  end
end
