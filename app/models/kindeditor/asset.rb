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

class Kindeditor::Asset < ActiveRecord::Base
  self.table_name = 'kindeditor_assets'
  mount_uploader :asset, Kindeditor::AssetUploader
  validates_presence_of :asset
  before_save :update_asset_attributes
  
  private
  def update_asset_attributes
    if asset.present? && asset_changed?
      self.file_size = asset.file.size
      self.file_type = asset.file.content_type
    end
  end
end
