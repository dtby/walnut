class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :content
      t.string :content_file_name
      t.string :content_content_type
      t.integer :content_file_size
      t.integer :attachmentable_id
      t.string :attachmentable_type
      t.string :file_url

      t.timestamps null: false
    end
  end
end
