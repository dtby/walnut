class AddNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :major, :string
    add_column :users, :department, :string
    add_column :users, :gender, :string
    add_column :users, :signature, :string
  end
end
