class FixLegistlationTypo < ActiveRecord::Migration
  def up
    rename_column :posts, :legistlation_id, :legislation_id
  end

  def down
  end
end
