class UserSession < Authlogic::Session::Base
  
  find_by_login_method :find_by_login_or_email
  
  disable_magic_states true
  remember_me true
  
  login_field :login
  password_field :password

  def self.oauth_consumer
    OAuth::Consumer.new("TOKEN", "SECRET",
    { :site=>"http://twitter.com",
      :authorize_url => "http://twitter.com/oauth/authenticate" })
  end
end