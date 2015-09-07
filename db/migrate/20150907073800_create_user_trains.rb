class CreateUserTrains < ActiveRecord::Migration
  def change
    create_table :user_trains do |t|
      t.integer :user_id
      t.integer :train_id

      t.timestamps null: false
    end
  end
end
