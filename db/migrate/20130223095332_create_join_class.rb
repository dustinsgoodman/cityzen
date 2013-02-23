class CreateJoinClass < ActiveRecord::Migration
  def up
    create_table :signatures do |t|
      t.integer :user_id
      t.integer :petition_id
      t.timestamps
    end
  end

  def down
  end
end
