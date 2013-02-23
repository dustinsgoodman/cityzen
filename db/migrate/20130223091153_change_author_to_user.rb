class ChangeAuthorToUser < ActiveRecord::Migration
  def up
    rename_column :petitions, :author_id, :user_id
  end

  def down
  end
end
