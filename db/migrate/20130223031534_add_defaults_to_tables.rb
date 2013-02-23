class AddDefaultsToTables < ActiveRecord::Migration
  def change
    change_column :petitions, :author_id, :integer, :nil => false
    change_column :petitions, :num_goal,  :integer, :default => 0
  end
end
