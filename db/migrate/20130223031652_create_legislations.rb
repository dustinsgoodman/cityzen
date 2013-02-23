class CreateLegislations < ActiveRecord::Migration
  def change
    create_table :legislations do |t|
      t.string :title
      t.text :content
      t.integer :num_for_votes
      t.integer :num_no_votes
      t.string :sponsor
      t.string :date
      t.boolean :passed?
      t.string :affected_location
      t.integer :ordinance_id
      t.integer :legislation_type

      t.timestamps
    end
  end
end
