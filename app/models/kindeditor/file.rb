# == Schema Information
#
# Table name: kindeditor_assets
#
#  id         :integer          not null, primary key
#  asset      :string(255)
#  file_size  :integer
#  file_type  :string(255)
#  owner_id   :integer
#  asset_type :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Kindeditor::File < Kindeditor::Asset
  mount_uploader :asset, Kindeditor::FileUploader
end
