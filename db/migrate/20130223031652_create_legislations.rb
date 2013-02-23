class CreateLegislations < ActiveRecord::Migration
  def change
    create_table :legislations do |t|
      t.string :title
      t.text :content
      t.int :num_for_votes
      t.int :num_no_votes
      t.string :sponsor
      t.string :date
      t.boolean :passed?
      t.string :affected_location
      t.int :ordinance_id
      t.int :legislation_type

      t.timestamps
    end
  end
end
