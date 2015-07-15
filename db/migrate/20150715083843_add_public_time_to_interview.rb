class AddPublicTimeToInterview < ActiveRecord::Migration
  def change
    add_column :interviews, :public_time, :string
    add_column :interviews, :image_url, :string
  end
end
