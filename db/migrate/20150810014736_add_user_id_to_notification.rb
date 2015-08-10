class AddUserIdToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :user, index: true
    add_column :notifications, :category, :integer, default: 0
  end
end
