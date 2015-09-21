class ChangeProfessionStagesAndTechnologyStages < ActiveRecord::Migration
  def change
  	change_table :profession_stages do |t|
  		t.rename :discribe, :description
  	end
  	change_table :technology_stages do |t|
  		t.rename :discribe, :description
  	end
  end
end
