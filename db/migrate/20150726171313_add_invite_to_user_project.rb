class AddInviteToUserProject < ActiveRecord::Migration
  def change
    add_column :user_projects, :invite, :boolean, defalut: false
  end
end
