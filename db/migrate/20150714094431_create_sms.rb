class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.string :mobile, null: false
      t.string :code, default: ""

      t.timestamps null: false
    end

    add_index :sms, :mobile,               unique: true
  end
end
