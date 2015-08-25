class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :openid
      t.boolean :sex, default: true
      t.string :phone
      t.string :qq
      t.string :email
      t.string :address
      t.string :situation
      t.string :degree
      t.string :way

      t.timestamps null: false
    end
  end
end
