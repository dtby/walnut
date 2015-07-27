class AddUserRefToAnnounce < ActiveRecord::Migration
  def change
    add_reference :announces, :user, index: true
  end
end
