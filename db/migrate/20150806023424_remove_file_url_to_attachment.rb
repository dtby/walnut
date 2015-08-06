class RemoveFileUrlToAttachment < ActiveRecord::Migration
  def change
    remove_column :attachments, :file_url
    remove_column :attachments, :sub_course_id
  end
end
