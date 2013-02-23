class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      #user personal info
      t.column :first_name,           :string,  :null => false
      t.column :middle_name,          :string
      t.column :last_name,            :string,  :null => false
      t.column :phone_number,         :string
      t.column :login,                :string,  :null => true, :limit => 20, :default => nil
      t.column :email,                :string,  :null => false, :limit => 100

      t.column :address,              :string
      t.column :address2,             :string
      t.column :city,                 :string, :null => false
      t.column :state,                :string, :null => false
      t.column :zip,                  :string, :null => false

      t.column :latitude,             :float
      t.column :longitude,            :float

      t.column :profile_pic,          :string
      t.column :facebook,             :string
      t.column :twitter,              :string
      
      #authlogic and password related fields
      t.column :oauth_token,          :string
      t.column :oauth_secret,         :string
      t.column :crypted_password,     :string,  :null => true, :default => nil
      t.column :password_salt,        :string,  :null => true, :default => nil
      t.column :persistence_token,    :string,  :null => false
      t.column :single_access_token,  :string,  :null => false
      t.column :perishable_token,     :string,  :null => false
      
      #session information
      t.column :login_count,          :integer, :null => false, :default => 0
      t.column :failed_login_count,   :integer, :null => false, :default => 0
      t.column :last_request_at,      :datetime
      t.column :current_login_at,     :datetime
      t.column :last_login_at,        :datetime
      t.column :current_login_ip,     :string
      t.column :last_login_ip,        :string
      
      #validation and other possible important times
      t.column :password_reset_at,    :datetime
      t.column :email_confimred_at,   :datetime
      t.column :tos_agreed_at,        :datetime
      
      #site and forum access level
      t.column :admin,                :boolean, :default => false
      t.column :moderator,            :boolean, :default => false
      t.column :event_coord,          :boolean, :default => false
      
      t.timestamps
    end
  
    add_index :users, :login, :unique => true
    add_index :users, :oauth_token
  end
  
  def down
    drop_table :users
  end
end