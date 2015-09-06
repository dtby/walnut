class AddProjectTypeToProject < ActiveRecord::Migration
  def change
    add_column :projects, :project_type, :integer, default: 0
  end
end
