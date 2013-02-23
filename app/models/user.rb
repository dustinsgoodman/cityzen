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
  before_save :set_district

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
    [fname, lname].join(" ")
  end
  
  private
    def set_district
      self.district = case zip
        when "30312", "30316", "30317"          then 1
        when "30308"                            then 2
        when "30363", "30309", "30332"          then 3
        when "30334", "30303", "30313"          then 4
        when "30316"                            then 5
        when "30307", "30324", "30306", "30309" then 6
        when "30319", "30326"                   then 7
        when "30327", "30305", "30342", "30326" then 8
        when "30318"                            then 9
        when "30331"                            then 10
        when "30311", "30310"                   then 11
        when "30354", "30315"                   then 12
        else 13
      end
  end
end
