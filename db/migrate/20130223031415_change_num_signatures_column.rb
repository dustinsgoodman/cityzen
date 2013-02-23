class ChangeNumSignaturesColumn < ActiveRecord::Migration
  def up
    change_column :petitions, :num_signatures, :integer, :default => 0
  end

  def down
  end
end
