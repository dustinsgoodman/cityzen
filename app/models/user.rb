class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :email
  end

  has_many :posts
  has_many :comments
  has_many :sub_comments

  attr_accessible :login, :first_name, :middle_name, :last_name,
  :phone_number, :email, :password, :password_confirmation,
  :address, :address2, :city, :state, :zip, :longitude, :latitude,
  :profile_pic, :facebook, :twitter

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  def self.find_by_login_or_email(login)
   find_by_login(login) || find_by_email(login)
  end

  def self.find_or_create(attrs)
    email = attrs[:email]
    user = nil
    if email
      begin
        connection.execute "LOCK TABLES users WRITE"
        user = find(:first, :conditions => {:email => email})
        unless user
          logger.info "User #{email} not found, creating"
          user = create(attrs)
        end
      ensure
        connection.execute "UNLOCK TABLES"
      end
      user
    else
      logger.error "Must specify email when creating user"
      nil
    end
  end

  def name
    [first_name, last_name].join(" ")
  end
end
