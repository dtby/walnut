class CreateUserRecruitments < ActiveRecord::Migration
  def change
    create_table :user_recruitments do |t|
      t.references :user, index: true
      t.references :recruitment, index: true
      t.integer :state, default: 0 

      t.timestamps null: false
    end
  end
end
