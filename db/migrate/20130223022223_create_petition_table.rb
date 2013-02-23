class CreatePetitionTable < ActiveRecord::Migration
  def up
    create_table :petitions do |t|
      t.string  :title
      t.integer :num_signatures
      t.integer :author_id
      t.integer :num_goal
      t.float   :longitude
      t.float   :latitude
      t.text    :content
    end
  end

  def down
    drop_table :petitions
  end
end
