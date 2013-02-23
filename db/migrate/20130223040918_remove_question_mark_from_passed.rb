class RemoveQuestionMarkFromPassed < ActiveRecord::Migration
  def up
    rename_column :legislations, :passed?, :status
  end

  def down
  end
end
