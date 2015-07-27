class CreateUserAnnounces < ActiveRecord::Migration
  def change
    create_table :user_announces do |t|
      t.references :user, index: true, foreign_key: true
      t.references :announce, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
