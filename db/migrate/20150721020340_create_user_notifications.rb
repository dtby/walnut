class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.references :user, index: true
      t.references :notification, index: true
      t.integer :state

      t.timestamps null: false
    end
  end
end
