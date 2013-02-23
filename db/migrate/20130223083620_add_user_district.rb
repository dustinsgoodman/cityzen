class AddUserDistrict < ActiveRecord::Migration
  def change
    add_column :users, :district, :integer
  end
end
