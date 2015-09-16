class CreateIternships < ActiveRecord::Migration
  def change
    create_table :iternships do |t|
      t.string :company
      t.string :time
      t.string :address
      t.string :job

      t.timestamps null: false
    end
  end
end
