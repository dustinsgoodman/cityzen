class ChangeAffectedLocationToDistrict < ActiveRecord::Migration
  def up
    remove_column :legislations, :affected_location
    add_column :legislations, :district, :integer
    add_column(:petitions, :created_at, :datetime)
    add_column(:petitions, :updated_at, :datetime)
  end

  def down
    remove_column :legislations, :district
    remove_column :petitions, :created_at
    remove_column :petitions, :updated_at
    add_column :legislations, :affected_location, :string
  end
end
