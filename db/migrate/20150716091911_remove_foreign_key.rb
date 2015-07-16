class RemoveForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key :interviews, :iv_categories
  end
end
