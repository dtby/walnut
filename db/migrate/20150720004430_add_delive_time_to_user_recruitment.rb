class AddDeliveTimeToUserRecruitment < ActiveRecord::Migration
  def change
    add_column :user_recruitments, :deliver_time, :time
  end
end
