class AddAttachmentPictureUrlToTrains < ActiveRecord::Migration
  def self.up
    change_table :trains do |t|
      t.attachment :picture_url
    end
  end

  def self.down
    remove_attachment :trains, :picture_url
  end
end
